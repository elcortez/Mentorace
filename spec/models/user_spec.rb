require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#has_finished_unit?' do
    let!(:user) { create(:user) }

    let!(:course) { create(:course) }
    let!(:chapter) { create(:chapter, course: course) }
    let!(:unit) { create(:unit, chapter: chapter) }

    let!(:unit_exercise) { create(:unit_exercise, unit: unit, position_in_unit: 1) }
  end

  describe '#has_finished_chapter?' do
  end

  describe '#has_finished_course?' do
  end
end
