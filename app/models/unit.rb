class Unit < ApplicationRecord
  belongs_to :chapter
  validates_presence_of :title
  has_many :unit_lessons
  has_many :unit_examples
  has_many :unit_images
  has_many :unit_exercises
  validate :unique_position_in_chapter

  def learning_elements
    (self.unit_lessons.to_a << self.unit_examples.to_a <<  self.unit_images.to_a)
      .compact
      .flatten
      .sort_by { |e| e.position_in_unit }
  end

  def unique_position_in_chapter
    return unless self.chapter.units.pluck(:position_in_chapter).include?(self.position_in_chapter)
    errors.add(:position_in_chapter, 'already taken')
  end

  def is_available_for_user?(current_user)
    return true if position_in_chapter == 1 && chapter.position_in_course == 1

    previous_chapters = Chapter.where(course_id: self.chapter.course_id).where(
      'position_in_course < :self_position_course',
      self_position_course: self.chapter.position_in_course
    )

    previous_units = Unit.where(chapter_id: previous_chapters.pluck(:id))
      .or(Unit.where(chapter_id: self.chapter_id).where(
        'position_in_chapter < :self_position_chapter',
        self_position_chapter: self.position_in_chapter
      ))

    previous_exercises = UnitExercise.where(unit_id: previous_units)

    exercise_attempts = current_user.exercise_attempts.where(
      unit_exercise_id: previous_exercises.pluck(:id),
      attempt_successful: true
    )

    exercise_attempts.pluck(:unit_exercise_id).sort == previous_exercises.pluck(:id)
  end
end
