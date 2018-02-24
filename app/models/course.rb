class Course < ApplicationRecord
  validates_presence_of :title
  has_many :chapters
  has_one :learning_status

  def create_learning_status_for_user(user_id)
    return if LearningStatus.find_by(user_id: user_id, course_id: self.id)

    chapter = self.chapters.order(:position_in_course).first
    return unless chapter.present?

    unit = chapter.units.order(:position_in_chapter).first
    return unless unit.present?

    exercise = unit.exercises.order(:position_in_unit).first
    return unless exercise.present?

    LearningStatus.create!(
      user_id: user_id,
      course_id: self.id,
      chapter_id: chapter.id,
      unit_id: unit.id,
      exercise_id: exercise.id,
    )
  end
end
