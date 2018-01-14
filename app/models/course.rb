class Course < ApplicationRecord
  validates_presence_of :title
  has_many :chapters
  validates_presence_of :title
end
