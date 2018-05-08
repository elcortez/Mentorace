class Belt < ApplicationRecord
  belongs_to :user
  belongs_to :course

  LEVELS = {
    1 => { belt_color: :white, grade: :rokukyu, rank: :kyu_6, max_xp: 10 },
    2 => { belt_color: :yellow, grade: :gokyu, rank: :kyu_5, max_xp: 20 },
    3 => { belt_color: :orange, grade: :yonkyu, rank: :kyu_4, max_xp: 30 },
    4 => { belt_color: :green, grade: :sankyu, rank: :kyu_3, max_xp: 40 },
    5 => { belt_color: :blue, grade: :nikyu, rank: :kyu_2, max_xp: 45 },
    6 => { belt_color: :brown, grade: :ikkyu, rank: :kyu_1, max_xp: 60 },
    7 => { belt_color: :black, grade: :shodan, rank: :dan_1, max_xp: 70 },
    8 => { belt_color: :black, grade: :nidan, rank: :dan_2, max_xp: 70 },
    9 => { belt_color: :black, grade: :sandan, rank: :dan_3, max_xp: 70 },
    10 => { belt_color: :black, grade: :yodan, rank: :dan_4, max_xp: 70 },
    11 => { belt_color: :black, grade: :godan, rank: :dan_5, max_xp: 70 },
    12 => { belt_color: :white_red, grade: :rokudan, rank: :dan_6, max_xp: 90 },
    13 => { belt_color: :white_red, grade: :shuchidan, rank: :dan_7, max_xp: 90 },
    14 => { belt_color: :white_red, grade: :hachidan, rank: :dan_8, max_xp: 95 },
    15 => { belt_color: :red, grade: :kudan, rank: :dan_9, max_xp: 110 },
    16 => { belt_color: :red, grade: :judan, rank: :dan_10, max_xp: 110 },
    17 => { belt_color: :white_large, grade: :junidan, rank: :dan_12, max_xp: 150 }
  }

  validates :level, inclusion: { in: LEVELS.keys }
  validates :color, inclusion: { in: LEVELS.values.map { |b| b[:belt_color].to_s } }
  validates :grade, inclusion: { in: LEVELS.values.map { |b| b[:grade].to_s } }
end
