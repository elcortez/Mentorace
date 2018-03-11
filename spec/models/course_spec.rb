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

  describe 'validates_presence_of :title_en' do
    let(:course) { Course.new }

    it 'will refuse validation if no title_en' do
      expect(course.save). to be false
      expect(course.errors.messages).to eql(title_en: ["can't be blank"])
    end

    it 'will accept validation with some title_en' do
      course.title_en = 'awesome course title_en'
      expect(course.save).to be true
    end
  end
end
