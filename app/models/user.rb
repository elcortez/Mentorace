class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :attempts
  has_many :learning_statuses

  after_create :create_learning_statuses

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
