class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :attempts
  has_many :learning_statuses
  has_many :belts

  has_many :current_belts, ->(user) {
    user.belts.joins('LEFT OUTER JOIN belts as latest_belts
      ON latest_belts.course_id = belts.course_id
      AND latest_belts.user_id = belts.user_id
      AND latest_belts.level > belts.level')
    .where('latest_belts.id IS NULL')
  }, class_name: 'Belt'

  after_create :create_learning_statuses
  after_create :create_first_belts

  def current_belt_for_course(course_id)
    self.current_belts.find_by(course_id: course_id)
  end

  def create_first_belts
    Course.find_each { |course| course.create_belts_for_user(self.id) }
  end

  def create_learning_statuses
    Course.find_each { |course| course.create_learning_status_for_user(self.id) }
  end

  def has_finished_exercise?(exercise)
    self.attempts.where(exercise_id: exercise.id, attempt_successful: true).any?
  end

  def can_access_exercise?(exercise)
    previous_exercise = exercise.previous_exercise
    previous_exercise.blank? || self.has_finished_exercise?(previous_exercise)
  end

  def can_access_lesson?(lesson)
    previous_lesson = lesson.previous_lesson
    previous_lesson.blank? || self.has_finished_lesson?(previous_lesson)
  end

  def has_finished_lesson?(lesson)
    exercises_id = lesson.exercises.pluck(:id).sort
    attempts_id = self.attempts
      .where(exercise_id: exercises_id, attempt_successful: true)
      .pluck(:exercise_id)
      .uniq
      .sort

    exercises_id == attempts_id
  end
end
