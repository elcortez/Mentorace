class Unit < ApplicationRecord
  belongs_to :chapter
  validates_presence_of :title
  has_many :unit_lessons
  has_many :unit_examples
  has_many :unit_exercises
end
