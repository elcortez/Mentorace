require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'create_learning_statuses' do
    let!(:course) { create(:course) }
    let!(:chapter) { create(:chapter, course: course) }
    let!(:unit) { create(:unit, chapter: chapter) }
    let!(:exercise) { create(:exercise, unit: unit, position_in_unit: 1) }

    it 'will automaticallly create a learning_status for each course' do
      user = create(:user)
      user.reload
      expect(user.learning_statuses.count).to eql(1)

      status = user.learning_statuses.first
      expect(status.attributes.except('created_at', 'id', 'updated_at')).to eql(
        'user_id' => user.id,
        'course_id' => course.id,
        'chapter_id' => chapter.id,
        'unit_id' => unit.id,
        'exercise_id' => exercise.id
      )
    end
  end
end
