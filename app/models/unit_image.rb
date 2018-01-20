class UnitImage < ApplicationRecord
  belongs_to :unit
  validates_presence_of :img_url
end
