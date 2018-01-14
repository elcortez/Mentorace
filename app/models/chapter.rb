class Chapter < ApplicationRecord
  belongs_to :course
  validates_presence_of :title
end
