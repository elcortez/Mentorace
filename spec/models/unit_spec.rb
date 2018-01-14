require 'rails_helper'

RSpec.describe Unit, type: :model do
  describe 'validates_presence_of :title' do
    let(:course) { Course.new(title: 'awesome title') }
    let(:chapter) { Chapter.new(course: course) }
    let(:unit) { Unit.new(chapter: chapter) }

    it 'will refuse validation if no title' do
      expect(unit.save). to be false
      expect(unit.errors.messages).to eql(title: ["can't be blank"])
    end

    it 'will accept validation with some title' do
      unit.title = 'awesome unit title'
      expect(unit.save).to be true
    end
  end
end
