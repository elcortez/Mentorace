require 'rails_helper'

RSpec.describe ExerciseAttempt, type: :model do
  describe '#set_successful' do
    let!(:unit_exercise) { create(:unit_exercise,
      question: double('question'),
      unit: create(:unit, chapter: create(:chapter, course: create(:course))),
      answer: '123'
    ) }

    let!(:user) { create(:user) }
    let!(:successful_attempt) { create(:exercise_attempt,
      unit_exercise: unit_exercise, attempted_answer: '123', user: user) }

    let!(:failed_attempt) { create(:exercise_attempt,
      unit_exercise: unit_exercise, attempted_answer: '1234', user: user) }

    it 'sets successful and failure on create' do
      expect(successful_attempt.attempt_successful).to eql(true)
      expect(failed_attempt.attempt_successful).to eql(false)
    end
  end

  describe '#update_learning_status' do
    let!(:course) { create(:course) }
    let!(:chapter) { create(:chapter, course: course) }
    let!(:unit) { create(:unit, chapter: chapter) }
    let!(:unit_exercise) { create(:unit_exercise, unit: unit, position_in_unit: 1) }
    let!(:unit_exercise_2) { create(:unit_exercise, unit: unit, position_in_unit: 2) }

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
          'unit_exercise_id' => unit_exercise.id
        )
      )

      create(:exercise_attempt, user: user, unit_exercise: unit_exercise, attempted_answer: unit_exercise.answer)
      user.reload

      expect(user.learning_statuses.first.attributes
        .except('created_at', 'id', 'updated_at')
        .to eql(
          'user_id' => user.id,
          'course_id' => course.id,
          'chapter_id' => chapter.id,
          'unit_id' => unit.id,
          'unit_exercise_id' => unit_exercise_2.id
        )
      )
    end
  end
end
