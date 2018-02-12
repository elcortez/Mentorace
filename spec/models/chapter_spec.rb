require 'rails_helper'

RSpec.describe Chapter, type: :model do
  describe 'validations / relations' do
    let!(:course) { create(:course) }
    let!(:chapter) { create(:chapter, course: course, position_in_course: 1) }
    let!(:chapter_2) { create(:chapter, course: course, position_in_course: 2) }
    let!(:chapter_3) { create(:chapter, course: course, position_in_course: 3) }

    it 'has_one :next_chapter' do
      expect(chapter.next_chapter.id).to eql(chapter_2.id)
      expect(chapter_2.next_chapter.id).to eql(chapter_3.id)
      expect(chapter_3.next_chapter).to eql(nil)
    end

    it 'has_one :previous_chapter' do
      expect(chapter.previous_chapter).to eql(nil)
      expect(chapter_2.previous_chapter.id).to eql(chapter.id)
      expect(chapter_3.previous_chapter.id).to eql(chapter_2.id)
    end

    it 'will refuse validation if no title' do
      chapter.title = nil
      expect(chapter.save).to be false
      expect(chapter.errors.messages).to eql(title: ["can't be blank"])
    end

    it 'will accept validation with some title' do
      chapter.title = 'awesome chapter title'
      expect(chapter.save).to be true
    end

    it 'will not save if position_in_course is already taken' do
      chapter.position_in_course = 2
      expect(chapter.save).to be false
      expect(chapter.errors.messages).to eql(position_in_course: ['already taken'])
    end
  end
end
