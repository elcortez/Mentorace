class Course < ApplicationRecord
  validates_presence_of :title
  has_many :chapters
  has_one :learning_status
end
