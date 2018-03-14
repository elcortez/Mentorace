class Example < ApplicationRecord
  belongs_to :unit

  validate :unique_position_in_unit
  validates_presence_of :content_en

  def unique_position_in_unit
    return unless self.unit.examples.pluck(:position_in_unit).include?(self.position_in_unit)
    errors.add(:position_in_unit, 'already taken')
  end
end
