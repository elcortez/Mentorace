require 'rails_helper'

RSpec.describe UnitExercise, type: :model do
  describe 'validations' do
    let!(:course) { create(:course) }
    let!(:chapter) { create(:chapter, course: course) }
    let!(:unit) { create(:unit, chapter: chapter) }
    let!(:unit_exercise) { create(:unit_exercise, unit: unit, position_in_unit: 1) }

    it '#unique_exercise_position_in_unit' do
      unit_exercise_2 = UnitExercise.new(unit: unit, position_in_unit: 1)
      expect(unit_exercise_2.save).to eql(false)
      expect(unit_exercise_2.errors.messages).to eql(position_in_unit: ['already taken'])
    end
  end

  describe 'can_access_exercise?' do
    let!(:course) { create(:course) }
    let!(:chapter) { create(:chapter, course: course) }
    let!(:unit) { create(:unit, chapter: chapter) }
    let!(:unit_exercise) { create(:unit_exercise, unit: unit, position_in_unit: 1) }
    let!(:unit_exercise) { create(:unit_exercise, unit: unit, position_in_unit: 2) }

    it 'can access a first one' do
    end

    it 'cannot access a second one if first one not validated' do
    end
  end
end
