class Belt < ApplicationRecord
  belongs_to :user
  belongs_to :course

  LEVELS = [*1..17]

  validates :level, inclusion: { in: LEVELS }
end
