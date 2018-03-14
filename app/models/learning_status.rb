class LearningStatus < ApplicationRecord
  belongs_to :user
  belongs_to :course
  belongs_to :chapter
  belongs_to :lesson
  belongs_to :exercise
end
