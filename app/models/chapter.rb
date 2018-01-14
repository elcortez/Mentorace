class Chapter < ApplicationRecord
  belongs_to :course
  has_many :units
  validates_presence_of :title
end
