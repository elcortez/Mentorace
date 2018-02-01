class Chapter < ApplicationRecord
  belongs_to :course
  has_many :units
  has_one :learning_status
  validates_presence_of :title
  validate :unique_position_in_course

  def unique_position_in_course
    return unless self.course.chapters.pluck(:position_in_course).include?(self.position_in_course)
    errors.add(:position_in_course, 'already taken')
  end
end
