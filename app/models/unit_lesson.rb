class UnitLesson < ApplicationRecord
  belongs_to :unit
  validates_presence_of :content
  validates_presence_of :position_in_unit
end
