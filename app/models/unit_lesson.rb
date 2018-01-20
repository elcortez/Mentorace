class UnitLesson < ApplicationRecord
  belongs_to :unit
  validates_presence_of :content
end
