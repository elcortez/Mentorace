class LearningStatus < ApplicationRecord
  belongs_to :user
  belongs_to :course
  belongs_to :chapter
  belongs_to :unit
  belongs_to :unit_exercise
end
