class UnitImage < ApplicationRecord
  include LearningElementConcern

  belongs_to :unit

  validate :unique_position_in_unit
  validates_presence_of :img_url
end
