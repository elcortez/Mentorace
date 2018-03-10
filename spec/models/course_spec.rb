require 'rails_helper'

RSpec.describe Course, type: :model do
  describe 'create_learning_status_for_user' do
    let!(:user) { create(:user) }
    let!(:course) { create(:course) }
    let!(:chapter) { create(:chapter, course: course) }
    let!(:unit) { create(:unit, chapter: chapter) }
    let!(:exercise) { create(:exercise, unit: unit, position_in_unit: 1) }


    it 'will create learning_status and be idempotent' do
      expect(Course.count).to eql(1)
      expect(user.learning_statuses.count).to eql(0)
      course.create_learning_status_for_user(user.id)
      course.create_learning_status_for_user(user.id)
      course.create_learning_status_for_user(user.id)
      course.create_learning_status_for_user(user.id)
      course.create_learning_status_for_user(user.id)

      expect(user.learning_statuses.count).to eql(1)
    end
  end

  describe '#display_title, #display_description' do
    let!(:course) { create(:course, title: 'maths_for_cs') }

    it '#display_title' do
      expect(I18n).to receive(:translate).with(
        'course.maths_for_cs.title'
      ) { 'Mathematics for Computer Science' }

      expect(course.display_title).to eql('Mathematics for Computer Science')
    end

    it '#display_description' do
      expect(I18n).to receive(:translate).with(
        'course.maths_for_cs.description'
      ) { 'Description for Maths for CS' }

      expect(course.display_description).to eql('Description for Maths for CS')
    end
  end

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
