require 'rails_helper'

RSpec.describe UnitExample, type: :model do
  describe 'validations' do
    let(:course) { Course.create(title: 'awesome title') }
    let(:chapter) { Chapter.create(course: course, position_in_course: 1, title: 'title') }
    let(:unit) { Unit.create(chapter: chapter, position_in_chapter: 1, title: 'title') }
    let(:unit_example) { UnitExample.new(unit: unit, content: 'content', position_in_unit: 1) }

    it 'will not save if position_in_unit is already taken' do
      UnitExample.create(unit: unit, position_in_unit: 1, content: 'content')

      expect(unit_example.save).to be false
      expect(unit_example.errors.messages).to eql(position_in_unit: ['already taken'])
    end
  end
end
