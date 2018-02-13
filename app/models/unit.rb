class Unit < ApplicationRecord
  belongs_to :chapter
  validates_presence_of :title
  validate :unique_position_in_chapter

  has_many :unit_lessons
  has_many :unit_examples
  has_many :unit_images
  has_many :exercises
  has_one :learning_status

  has_one :next_unit_in_chapter, -> (unit) {
    where(
      position_in_chapter: unit.position_in_chapter + 1,
      chapter_id: unit.chapter_id
    ).limit(1)
  }, through: :chapter, source: :units

  has_one :previous_unit_in_chapter, -> (unit) {
    where(
      position_in_chapter: unit.position_in_chapter - 1,
      chapter_id: unit.chapter_id
    ).limit(1)
  }, through: :chapter, source: :units


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
end
