require 'rails_helper'

RSpec.describe UnitExample, type: :model do
  describe 'validations' do
    let!(:course) { create(:course, title: 'awesome title') }
    let!(:chapter) { create(:chapter, course: course, position_in_course: 1, title: 'title') }
    let!(:unit) { create(:unit, chapter: chapter, position_in_chapter: 1, title: 'title') }
    let!(:unit_example) { create(:unit_example, unit: unit, content: 'content', position_in_unit: 1) }

    it 'will not save if position_in_unit is already taken' do
      unit.reload
      unit_example.reload

      unit_example_2 = UnitExample.new(unit: unit, position_in_unit: 1, content: 'content')

      expect(unit_example_2.save).to be false
      expect(unit_example_2.errors.messages).to eql(position_in_unit: ['already taken'])
    end
  end
end
