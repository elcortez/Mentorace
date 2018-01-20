class UnitImage < ApplicationRecord
  belongs_to :unit
  validates_presence_of :img_url
  validate :unique_position_in_unit

  def unique_position_in_unit
    return unless self.unit.unit_learning_elements.pluck(:position_in_unit).include?(self.position_in_unit)
    errors.add(:position_in_unit, 'already taken')
  end
end
