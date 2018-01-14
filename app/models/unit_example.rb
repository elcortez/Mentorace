class UnitExample < ApplicationRecord
  belongs_to :unit
  validates_presence_of :content
  validates_presence_of :unit_position
end
