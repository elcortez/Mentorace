class Unit < ApplicationRecord
  belongs_to :chapter
  validates_presence_of :title
end
