require 'rails_helper'

RSpec.describe Course, type: :model do
  describe 'validates_presence_of :title' do
    let(:course) { Course.new }

    it 'will refuse validation if no title' do
      expect(course.save). to be false
      expect(course.errors.messages).to eql(title: ["can't be blank"])
    end

    it 'will accept validation with some title' do
      course.title = 'awesome course title'
      expect(course.save).to be true
    end
  end
end
