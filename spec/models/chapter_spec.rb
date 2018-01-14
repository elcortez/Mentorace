require 'rails_helper'

RSpec.describe Chapter, type: :model do
    describe 'validates_presence_of :title' do
    let!(:course) { Course.new(title: 'awesome title') }
    let(:chapter) { Chapter.new(course: course) }

    it 'will refuse validation if no title' do
      expect(chapter.save). to be false
      expect(chapter.errors.messages).to eql(title: ["can't be blank"])
    end

    it 'will accept validation with some title' do
      chapter.title = 'awesome chapter title'
      expect(chapter.save).to be true
    end
  end

end
