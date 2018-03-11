require 'rails_helper'

RSpec.describe Chapter, type: :model do
  describe 'validations / relations' do
    let!(:course) { create(:course) }
    let!(:chapter) { create(:chapter, course: course, position_in_course: 1) }
    let!(:chapter_2) { create(:chapter, course: course, position_in_course: 2) }
    let!(:chapter_3) { create(:chapter, course: course, position_in_course: 3) }

    it 'has_one :next_chapter_in_course' do
      expect(chapter.next_chapter_in_course.id).to eql(chapter_2.id)
      expect(chapter_2.next_chapter_in_course.id).to eql(chapter_3.id)
      expect(chapter_3.next_chapter_in_course).to eql(nil)
    end

    it 'has_one :previous_chapter_in_course' do
      expect(chapter.previous_chapter_in_course).to eql(nil)
      expect(chapter_2.previous_chapter_in_course.id).to eql(chapter.id)
      expect(chapter_3.previous_chapter_in_course.id).to eql(chapter_2.id)
    end

    it 'will refuse validation if no title_en' do
      chapter.title_en = nil
      expect(chapter.save).to be false
      expect(chapter.errors.messages).to eql(title_en: ["can't be blank"])
    end

    it 'will accept validation with some title_en' do
      chapter.title_en = 'awesome chapter title_en'
      expect(chapter.save).to be true
    end

    it 'will not save if position_in_course is already taken' do
      chapter.position_in_course = 2
      expect(chapter.save).to be false
      expect(chapter.errors.messages).to eql(position_in_course: ['already taken'])
    end
  end
end
