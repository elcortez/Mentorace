class UnitExample < ApplicationRecord
  belongs_to :unit
  validates_presence_of :content
  validates_presence_of :position_in_unit
  validate :unique_position_in_unit

  def unique_position_in_unit
    return unless self.unit.unit_examples.pluck(:position_in_unit).include?(self.position_in_unit)
    errors.add(:position_in_unit, 'already taken')
  end
end
