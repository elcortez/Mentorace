class Unit < ApplicationRecord
  belongs_to :chapter
  validates_presence_of :title
  has_many :unit_lessons
end
