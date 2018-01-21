class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :exercise_attempts

  def has_finished_unit?(unit)
    exercises_ids = unit.unit_exercises.pluck(:id).sort

    attempts = self.exercise_attempts.where(
      attempt_successful: true,
      unit_exercise_id: exercises_ids
    ).pluck(:unit_exercise_id).uniq.sort

    attempts == exercises_ids
  end
end
