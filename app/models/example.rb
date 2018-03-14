class Example < ApplicationRecord
  belongs_to :lesson

  validate :unique_position_in_lesson
  validates_presence_of :content_en

  def unique_position_in_lesson
    return unless self.lesson.examples.pluck(:position_in_lesson).include?(self.position_in_lesson)
    errors.add(:position_in_lesson, 'already taken')
  end
end
