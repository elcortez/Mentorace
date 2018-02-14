class Chapter < ApplicationRecord
  belongs_to :course
  has_many :units
  has_one :learning_status
  validates_presence_of :title
  validate :unique_position_in_course

  has_one :next_chapter_in_course, -> (chapter) {
    where(
      position_in_course: chapter.position_in_course + 1,
      course_id: chapter.course_id
    ).limit(1)
  }, through: :course, source: :chapters

  has_one :previous_chapter_in_course, -> (chapter) {
    where(
      position_in_course: chapter.position_in_course - 1,
      course_id: chapter.course_id
    ).limit(1)
  }, through: :course, source: :chapters

  def unique_position_in_course
    return unless self.course.chapters.where.not(id: self.id).pluck(:position_in_course).include?(self.position_in_course)
    errors.add(:position_in_course, 'already taken')
  end

  def units_ordered
    self.units.order(:position_in_chapter)
  end
end
