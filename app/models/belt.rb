class Belt < ApplicationRecord
  belongs_to :user
  belongs_to :course

  LEVELS = {
    1 => { belt_color: :white, grade: :rokukyu, rank: :kyu_6 },
    2 => { belt_color: :yellow, grade: :gokyu, rank: :kyu_5 },
    3 => { belt_color: :orange, grade: :yonkyu, rank: :kyu_4 },
    4 => { belt_color: :green, grade: :sankyu, rank: :kyu_3 },
    5 => { belt_color: :blue, grade: :nikyu, rank: :kyu_2 },
    6 => { belt_color: :brown, grade: :ikkyu, rank: :kyu_1 },
    7 => { belt_color: :black, grade: :shodan, rank: :dan_1 },
    8 => { belt_color: :black, grade: :nidan, rank: :dan_2 },
    9 => { belt_color: :black, grade: :sandan, rank: :dan_3 },
    10 => { belt_color: :black, grade: :yodan, rank: :dan_4 },
    11 => { belt_color: :black, grade: :godan, rank: :dan_5 },
    12 => { belt_color: :white_red, grade: :rokudan, rank: :dan_6 },
    13 => { belt_color: :white_red, grade: :shuchidan, rank: :dan_7 },
    14 => { belt_color: :white_red, grade: :hachidan, rank: :dan_8 },
    15 => { belt_color: :red, grade: :kudan, rank: :dan_9 },
    16 => { belt_color: :red, grade: :judan, rank: :dan_10 },
    17 => { belt_color: :red, grade: :junidan, rank: :dan_12 }
  }

  validates :level, inclusion: { in: LEVELS.keys }
  validates :color, inclusion: { in: LEVELS.values.map { |b| b[:belt_color].to_s } }
  validates :grade, inclusion: { in: LEVELS.values.map { |b| b[:grade].to_s } }
end
