class Course < ApplicationRecord
  validates_presence_of :title_en
  has_many :chapters
  has_one :learning_status
  has_many :belts

  def display_title
    self.send("title_#{I18n.locale}")
  end

  def create_belts_for_user(user_id)
    return if Belt.find_by(user_id: user_id, course_id: self.id)
    Belt.create!(
      user_id: user_id,
      course_id: self.id,
      level: 1,
      color: :white,
      grade: :rokukyu
    )
  end

  def create_learning_status_for_user(user_id)
    return if LearningStatus.find_by(user_id: user_id, course_id: self.id)

    chapter = self.chapters.order(:position_in_course).first
    return unless chapter.present?

    lesson = chapter.lessons.order(:position_in_chapter).first
    return unless lesson.present?

    exercise = lesson.exercises.order(:position_in_lesson).first
    return unless exercise.present?

    LearningStatus.create!(
      user_id: user_id,
      course_id: self.id,
      chapter_id: chapter.id,
      lesson_id: lesson.id,
      exercise_id: exercise.id,
    )
  end
end
