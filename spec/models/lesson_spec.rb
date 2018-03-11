require 'rails_helper'

RSpec.describe Lesson, type: :model do
  describe 'validations' do
    let!(:course) { create(:course, title_en: 'awesome title_en') }
    let!(:chapter) { create(:chapter, course: course, position_in_course: 1, title_en: 'title_en') }
    let!(:unit) { create(:unit, chapter: chapter, position_in_chapter: 1, title_en: 'title_en') }
    let!(:lesson) { create(:lesson, unit: unit, content_en: 'content', position_in_unit: 1) }

    it 'will not save if position_in_unit is already taken' do
      unit.reload
      lesson.reload

      lesson_2 = Lesson.new(unit: unit, position_in_unit: 1, content_en: 'content')

      expect(lesson_2.save).to be false
      expect(lesson_2.errors.messages).to eql(position_in_unit: ['already taken'])
    end
  end
end
