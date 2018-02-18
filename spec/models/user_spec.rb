require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#has_finished_exercise?, #can_access_exercise?' do
    let!(:course) { create(:course) }
    let!(:chapter) { create(:chapter, course: course) }
    let!(:unit) { create(:unit, chapter: chapter) }
    let!(:exercise) { create(:exercise, unit: unit, position_in_unit: 1) }
    let!(:exercise_2) { create(:exercise, unit: unit, position_in_unit: 2) }

    let!(:user) { create(:user) }

    it 'returns false if user has not finished exercise' do
      expect(user.has_finished_exercise?(exercise)).to eql(false)
      expect(user.has_finished_exercise?(exercise_2)).to eql(false)
    end

    it 'returns true if user has finished exercise' do
      create(:attempt, user: user, exercise: exercise, attempted_answer: exercise.answer)

      user.reload
      expect(user.has_finished_exercise?(exercise)).to eql(true)
      expect(user.has_finished_exercise?(exercise_2)).to eql(false)
    end

    it 'returns true if user has finished exercise 2' do
      create(:attempt, user: user, exercise: exercise_2, attempted_answer: exercise_2.answer)

      user.reload
      expect(user.has_finished_exercise?(exercise)).to eql(false)
      expect(user.has_finished_exercise?(exercise_2)).to eql(true)
    end

    it 'can access exercise if there is not other before it' do
      expect(user.can_access_exercise?(exercise)).to eql(true)
    end

    it 'cannot access exercise if the one before it is not finished' do
      expect(user.can_access_exercise?(exercise_2)).to eql(false)
    end

    it 'can access exercise if the one before it is finished' do
      create(:attempt, user: user, exercise: exercise, attempted_answer: exercise.answer)
      expect(user.can_access_exercise?(exercise_2)).to eql(true)
    end
  end


  describe 'create_learning_statuses' do
    let!(:course) { create(:course) }
    let!(:chapter) { create(:chapter, course: course) }
    let!(:unit) { create(:unit, chapter: chapter) }
    let!(:exercise) { create(:exercise, unit: unit, position_in_unit: 1) }

    it 'will automatically create a learning_status for each course' do
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
