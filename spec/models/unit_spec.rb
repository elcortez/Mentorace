require 'rails_helper'

RSpec.describe Unit, type: :model do
  describe '.learning_elements' do
    let!(:course) { create(:course, title: 'awesome title') }
    let!(:chapter) { create(:chapter, course: course, position_in_course: 1) }
    let!(:unit) { create(:unit, chapter: chapter, position_in_chapter: 1) }
    let!(:unit_example) { create(:unit_example, unit: unit, position_in_unit: 1, content: 'content') }
    let!(:unit_image) { create(:unit_image, unit: unit, position_in_unit: 2, img_url: 'url') }
    let!(:unit_lesson) { create(:unit_lesson, unit: unit, position_in_unit: 3, content: 'content') }

    it 'can find its learning_elements' do
      unit.reload
      expect(unit.learning_elements.map(&:id)).to eql([
        unit_example.id, unit_image.id, unit_lesson.id
      ])
    end
  end

  describe 'validations' do
    let(:course) { create(:course, title: 'awesome title') }
    let(:chapter) { create(:chapter, course: course, position_in_course: 1) }

    it 'will refuse validation if no title' do
      unit = Unit.new(title: nil, chapter: chapter)
      expect(unit.save). to be false
      expect(unit.errors.messages).to eql(title: ["can't be blank"])

      unit.title = 'awesome unit title'
      expect(unit.save).to be true
    end

    it 'will not save if position_in_chapter is already taken' do
      create(:unit, chapter: chapter, position_in_chapter: 1)

      unit = Unit.new(title: 'title', chapter: chapter, position_in_chapter: 1)
      expect(unit.save).to be false
      expect(unit.errors.messages).to eql(position_in_chapter: ['already taken'])
    end
  end
end
