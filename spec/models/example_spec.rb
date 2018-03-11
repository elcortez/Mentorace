require 'rails_helper'

RSpec.describe Example, type: :model do
  describe 'validations' do
    let!(:course) { create(:course, title_en: 'awesome title_en') }
    let!(:chapter) { create(:chapter, course: course, position_in_course: 1, title_en: 'title_en') }
    let!(:unit) { create(:unit, chapter: chapter, position_in_chapter: 1, title_en: 'title_en') }
    let!(:example) { create(:example, unit: unit, content_en: 'content', position_in_unit: 1) }

    it 'will not save if position_in_unit is already taken' do
      unit.reload
      example.reload

      example_2 = Example.new(unit: unit, position_in_unit: 1, content_en: 'content')

      expect(example_2.save).to be false
      expect(example_2.errors.messages).to eql(position_in_unit: ['already taken'])
    end
  end
end
