require 'rails_helper'

RSpec.describe Attempt, type: :model do
  describe '#set_successful' do
    let!(:exercise) { create(:exercise,
      question: double('question'),
      unit: create(:unit, chapter: create(:chapter, course: create(:course))),
      answer: '123'
    ) }

    let!(:user) { create(:user) }
    let!(:successful_attempt) { create(:attempt,
      exercise: exercise, attempted_answer: '123', user: user) }

    let!(:failed_attempt) { create(:attempt,
      exercise: exercise, attempted_answer: '1234', user: user) }

    it 'sets successful and failure on create' do
      expect(successful_attempt.attempt_successful).to eql(true)
      expect(failed_attempt.attempt_successful).to eql(false)
    end
  end

  describe '#update_learning_status' do
    let!(:course) { create(:course) }
    let!(:chapter) { create(:chapter, course: course) }
    let!(:unit) { create(:unit, chapter: chapter) }
    let!(:exercise) { create(:exercise, unit: unit, position_in_unit: 1) }
    let!(:exercise_2) { create(:exercise, unit: unit, position_in_unit: 2) }

    let!(:user) { create(:user) }

    it 'will update learning status if exercise attempt is successful' do
      expect(user.learning_statuses.count).to eql(1)
      expect(user.learning_statuses.first.attributes
        .except('created_at', 'id', 'updated_at')
        .to eql(
          'user_id' => user.id,
          'course_id' => course.id,
          'chapter_id' => chapter.id,
          'unit_id' => unit.id,
          'exercise_id' => exercise.id
        )
      )

      create(:attempt, user: user, exercise: exercise, attempted_answer: exercise.answer)
      user.reload

      expect(user.learning_statuses.first.attributes
        .except('created_at', 'id', 'updated_at')
        .to eql(
          'user_id' => user.id,
          'course_id' => course.id,
          'chapter_id' => chapter.id,
          'unit_id' => unit.id,
          'exercise_id' => exercise_2.id
        )
      )
    end
  end
end
