class Belt < ApplicationRecord
  belongs_to :user
  belongs_to :course

  LEVELS = [*1..17]

  validates :level, inclusion: { in: LEVELS }
  validates_presence_of :max_xp

  before_validation :define_max_xp, if: -> (b) { b.new_record? }

  def define_max_xp
    self.max_xp = MAX_XP[self.level]
  end

  # TODO Find a better way to handle this
  MAX_XP = {
    1 => 10,
    2 => 20,
    3 => 30,
    4 => 40,
    5 => 45,
    6 => 60,
    7 => 70,
    8 => 70,
    9 => 70,
    10 => 70,
    11 => 70,
    12 => 90,
    13 => 90,
    14 => 95,
    15 => 110,
    16 => 110,
    17 => 150
  }
end
