require 'rails_helper'

RSpec.describe Unit, type: :model do
  describe '.unit_learning_elements' do
    let!(:course) { create(:course, title: 'awesome title') }
    let!(:chapter) { create(:chapter, course: course, position_in_course: 1) }
    let!(:unit) { create(:unit, chapter: chapter, position_in_chapter: 1) }
    let!(:unit_example) { create(:unit_example, unit: unit, position_in_unit: 1, content: 'content') }
    let!(:unit_image) { create(:unit_image, unit: unit, position_in_unit: 2, img_url: 'url') }
    let!(:unit_lesson) { create(:unit_lesson, unit: unit, position_in_unit: 3, content: 'content') }

    it 'can find its unit_learning_elements' do
      expect(unit.unit_learning_elements.map(&:id)).to eql([
        unit_example.id, unit_image.id, unit_lesson.id
      ])
    end
  end

  describe 'validates_presence_of :title' do
    let(:course) { Course.new(title: 'awesome title') }
    let(:chapter) { Chapter.new(course: course, position_in_course: 1) }
    let(:unit) { Unit.new(chapter: chapter, position_in_chapter: 1) }

    it 'will refuse validation if no title' do
      expect(unit.save). to be false
      expect(unit.errors.messages).to eql(title: ["can't be blank"])
    end

    it 'will accept validation with some title' do
      unit.title = 'awesome unit title'
      expect(unit.save).to be true
    end

    it 'will not save if position_in_chapter is already taken' do
      course.save
      chapter.title = 'title'
      chapter.save
      Unit.create(chapter_id: chapter.id, title: 'title', position_in_chapter: 1)

      unit.title = 'title'
      expect(unit.save).to be false
      expect(unit.errors.messages).to eql(position_in_chapter: ['already taken'])
    end
  end
end
