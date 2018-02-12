require 'rails_helper'

RSpec.describe UnitExercise, type: :model do
  describe 'validations / relations' do
    let!(:course) { create(:course) }

    let!(:chapter) { create(:chapter, course: course, position_in_course: 1) }
    let!(:unit) { create(:unit, chapter: chapter, position_in_chapter: 1) }
    let!(:unit_exercise_1) { create(:unit_exercise, unit: unit, position_in_unit: 1) }
    let!(:unit_exercise_2) { create(:unit_exercise, unit: unit, position_in_unit: 2) }
    let!(:unit_2) { create(:unit, chapter: chapter, position_in_chapter: 2) }
    let!(:unit_exercise_3) { create(:unit_exercise, unit: unit_2, position_in_unit: 1) }
    let!(:unit_exercise_4) { create(:unit_exercise, unit: unit_2, position_in_unit: 2) }

    let!(:chapter_2) { create(:chapter, course: course, position_in_course: 2) }
    let!(:unit_3) { create(:unit, chapter: chapter_2, position_in_chapter: 1) }
    let!(:unit_exercise_5) { create(:unit_exercise, unit: unit_3, position_in_unit: 1) }
    let!(:unit_exercise_6) { create(:unit_exercise, unit: unit_3, position_in_unit: 2) }

    it 'has_one :next_exercise' do
    end

    it 'has_one :previous_exercise' do
    end

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
