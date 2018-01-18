require 'rails_helper'

RSpec.describe Chapter, type: :model do
  describe 'validations' do
    let!(:course) { Course.new(title: 'awesome title') }
    let(:chapter) { Chapter.new(course: course, position_in_course: 1) }

    it 'will refuse validation if no title' do
      expect(chapter.save). to be false
      expect(chapter.errors.messages).to eql(title: ["can't be blank"])
    end

    it 'will accept validation with some title' do
      chapter.title = 'awesome chapter title'
      expect(chapter.save).to be true
    end

    it 'will not save if position_in_course is already taken' do
      Chapter.create(course: course, title: 'title', position_in_course: 1)
      chapter.title = 'title'
      expect(chapter.save).to be false
      expect(chapter.errors.messages).to eql(position_in_course: ['already taken'])
    end
  end
end
