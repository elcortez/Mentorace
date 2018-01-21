require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#has_finished_unit?' do
    let!(:user) { create(:user) }

    let!(:course) { create(:course) }
    let!(:chapter) { create(:chapter, course: course) }
    let!(:unit) { create(:unit, chapter: chapter) }

    let!(:unit_exercise) { create(:unit_exercise, unit: unit, position_in_unit: 1) }
    let!(:exercise_attempt) { create(:exercise_attempt,
      user: user,
      unit_exercise: unit_exercise,
      attempted_answer: unit_exercise.answer,
      attempt_successful: true
    ) }

    it 'will return true if user has at least one successful attempt per unit_exercise' do
      expect(user.has_finished_unit?(unit)).to eql(true)
    end

    it 'will return false if user has at not successful attempts per unit_exercise' do
      exercise_attempt.delete
      user.reload
      expect(user.has_finished_unit?(unit)).to eql(false)
    end

    it 'will return false if another exercise pops up' do
      create(:unit_exercise, unit: unit, position_in_unit: 2)
      user.reload
      expect(user.has_finished_unit?(unit)).to eql(false)
    end

    it 'will return false exercise_attempt is not successful' do
      exercise_attempt.update_columns(attempt_successful: false)
      user.reload
      expect(user.has_finished_unit?(unit)).to eql(false)
    end
  end
end
