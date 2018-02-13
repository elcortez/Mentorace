require 'rails_helper'

RSpec.describe Exercise, type: :model do
  describe 'validations / relations' do
    let!(:course) { create(:course) }

    let!(:chapter) { create(:chapter, course: course, position_in_course: 1) }
    let!(:unit) { create(:unit, chapter: chapter, position_in_chapter: 1) }
    let!(:exercise_1) { create(:exercise, unit: unit, position_in_unit: 1) }
    let!(:exercise_2) { create(:exercise, unit: unit, position_in_unit: 2) }
    let!(:unit_2) { create(:unit, chapter: chapter, position_in_chapter: 2) }
    let!(:exercise_3) { create(:exercise, unit: unit_2, position_in_unit: 1) }
    let!(:exercise_4) { create(:exercise, unit: unit_2, position_in_unit: 2) }

    let!(:chapter_2) { create(:chapter, course: course, position_in_course: 2) }
    let!(:unit_3) { create(:unit, chapter: chapter_2, position_in_chapter: 1) }
    let!(:exercise_5) { create(:exercise, unit: unit_3, position_in_unit: 1) }
    let!(:exercise_6) { create(:exercise, unit: unit_3, position_in_unit: 2) }

    it 'has_one :next_exercise_in_unit' do
      expect(exercise_1.next_exercise_in_unit.id).to eql(exercise_2.id)
      expect(exercise_2.next_exercise_in_unit).to eql(nil)
    end

    it 'has_one :previous_exercise_in_unit' do
      expect(exercise_1.previous_exercise_in_unit).to eql(nil)
      expect(exercise_2.previous_exercise_in_unit.id).to eql(exercise_1.id)
    end

    it '#unique_exercise_position_in_unit' do
      exercise_2 = Exercise.new(unit: unit, position_in_unit: 1)
      expect(exercise_2.save).to eql(false)
      expect(exercise_2.errors.messages).to eql(position_in_unit: ['already taken'])
    end
  end

  describe 'can_access_exercise?' do
    let!(:course) { create(:course) }
    let!(:chapter) { create(:chapter, course: course) }
    let!(:unit) { create(:unit, chapter: chapter) }
    let!(:exercise) { create(:exercise, unit: unit, position_in_unit: 1) }
    let!(:exercise) { create(:exercise, unit: unit, position_in_unit: 2) }

    it 'can access a first one' do
    end

    it 'cannot access a second one if first one not validated' do
    end
  end
end
