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
end
