class Lesson < ApplicationRecord
  include LearningElementConcern

  belongs_to :unit

  validate :unique_position_in_unit
  validates_presence_of :content_en
end
