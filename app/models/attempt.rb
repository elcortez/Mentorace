class Attempt < ApplicationRecord
  belongs_to :user
  belongs_to :exercise
  before_validation :set_successful
  after_create :update_learning_status
  after_create :give_experience

  scope :successful, -> {
    where(attempt_successful: true)
  }

  def set_successful
    return false unless self.attempted_answer.present?
    return false unless self.attempted_answer.gsub(/ /, '') == self.exercise.answer.gsub(/ /, '')
    self.attempt_successful = true
  end

  def give_experience
    return unless self.attempt_successful
    return unless self.only_successful_attempt_for_exercise?

    exercise = self.exercise

    belt = self.user.current_belt_for_course(exercise.lesson.chapter.course)

    return :max_belt_reached if belt.level == Belt::MAX_XP.keys.sort.last

    belt.current_xp += exercise.experience_given

    if belt.current_xp >= belt.max_xp
      xp_to_report = belt.current_xp - belt.max_xp
      create_new_belt(xp_to_report, belt)

      belt.current_xp = belt.max_xp
    end

    belt.save
  end

  def create_new_belt(xp_to_report, previous_belt)
    return :max_belt_reached if previous_belt.level == Belt::MAX_XP.keys.sort.last

    Belt.create(
      level: previous_belt.level + 1,
      current_xp: xp_to_report,
      user: self.user,
      course: self.exercise.lesson.chapter.course
    )
  end

  def only_successful_attempt_for_exercise?
    self.user.attempts.successful
      .where(exercise_id: [self.exercise.id])
      .where.not(id: self.id)
      .empty?
  end

  def update_learning_status
    return unless self.attempt_successful
    exercise = self.exercise

    learning_status = self.user.learning_statuses.find_by(
      exercise_id: exercise.id,
      user_id: self.user_id
    )

    return unless learning_status

    if exercise.next_exercise_in_lesson
      learning_status.exercise_id = exercise.next_exercise_in_lesson.id

    elsif next_lesson = exercise.lesson.next_lesson_in_chapter
      learning_status.lesson_id = next_lesson.id
      learning_status.exercise_id = next_lesson.exercises_ordered.first.id

    elsif next_chapter = exercise.lesson.chapter.next_chapter_in_course
      learning_status.chapter_id = next_chapter.id

      lesson = next_chapter.lessons_ordered.first
      learning_status.lesson_id = lesson.id
      learning_status.exercise_id = lesson.exercises_ordered.first.id

    else
      learning_status.finished_at = Time.now
    end

    learning_status.save
  end
end
