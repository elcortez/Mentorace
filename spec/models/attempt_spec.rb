require 'rails_helper'

RSpec.describe Attempt, type: :model do
  describe '#set_successful' do
    let!(:exercise) { create(:exercise,
      question_en: double('question'),
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

    let!(:chapter_1) { create(:chapter, course: course) }
    let!(:unit_1) { create(:unit, chapter: chapter_1) }
    let!(:exercise_1) { create(:exercise, unit: unit_1) }
    let!(:exercise_2) { create(:exercise, unit: unit_1, position_in_unit: 2) }

    let!(:unit_2) { create(:unit, chapter: chapter_1, position_in_chapter: 2) }
    let!(:exercise_3) { create(:exercise, unit: unit_2) }
    let!(:exercise_4) { create(:exercise, unit: unit_2, position_in_unit: 2) }

    let!(:chapter_2) { create(:chapter, course: course, position_in_course: 2) }
    let!(:unit_3) { create(:unit, chapter: chapter_2, position_in_chapter: 3) }
    let!(:exercise_5) { create(:exercise, unit: unit_3) }
    let!(:exercise_6) { create(:exercise, unit: unit_3, position_in_unit: 2) }

    let!(:user) { create(:user) }

    it 'basic learning_status' do
      expect(user.learning_statuses.count).to eql(1)
      expect(
        user.learning_statuses.first.attributes
        .except('created_at', 'id', 'updated_at')
      ).to eql(
        'user_id' => user.id,
        'course_id' => course.id,
        'chapter_id' => chapter_1.id,
        'unit_id' => unit_1.id,
        'exercise_id' => exercise_1.id
      )
    end

    it 'no update if wrong answer' do
      create(:attempt, user: user, exercise: exercise_1, attempted_answer: 'wrong answer')
      user.reload
      expect(user.learning_statuses.count).to eql(1)
      expect(
        user.learning_statuses.first.attributes
        .except('created_at', 'id', 'updated_at')
      ).to eql(
        'user_id' => user.id,
        'course_id' => course.id,
        'chapter_id' => chapter_1.id,
        'unit_id' => unit_1.id,
        'exercise_id' => exercise_1.id
      )
    end

    it 'update exercise 2' do
      create(:attempt, user: user, exercise: exercise_1, attempted_answer: exercise_1.answer)
      user.reload
      expect(user.learning_statuses.count).to eql(1)
      expect(
        user.learning_statuses.first.attributes
        .except('created_at', 'id', 'updated_at')
      ).to eql(
        'user_id' => user.id,
        'course_id' => course.id,
        'chapter_id' => chapter_1.id,
        'unit_id' => unit_1.id,
        'exercise_id' => exercise_2.id
      )
    end

    it 'update exercise 3, unit 2' do
      create(:attempt, user: user, exercise: exercise_1, attempted_answer: exercise_1.answer)
      create(:attempt, user: user, exercise: exercise_2, attempted_answer: exercise_2.answer)

      user.reload
      expect(user.learning_statuses.count).to eql(1)
      expect(
        user.learning_statuses.first.attributes
        .except('created_at', 'id', 'updated_at')
      ).to eql(
        'user_id' => user.id,
        'course_id' => course.id,
        'chapter_id' => chapter_1.id,
        'unit_id' => unit_2.id,
        'exercise_id' => exercise_3.id
      )
    end

    it 'update exercise 4, unit 2' do
      create(:attempt, user: user, exercise: exercise_1, attempted_answer: exercise_1.answer)
      create(:attempt, user: user, exercise: exercise_2, attempted_answer: exercise_2.answer)
      create(:attempt, user: user, exercise: exercise_3, attempted_answer: exercise_3.answer)

      user.reload
      expect(user.learning_statuses.count).to eql(1)
      expect(
        user.learning_statuses.first.attributes
        .except('created_at', 'id', 'updated_at')
      ).to eql(
        'user_id' => user.id,
        'course_id' => course.id,
        'chapter_id' => chapter_1.id,
        'unit_id' => unit_2.id,
        'exercise_id' => exercise_4.id
      )
    end

    it 'update exercise 5, unit 3, chapter 2' do
      create(:attempt, user: user, exercise: exercise_1, attempted_answer: exercise_1.answer)
      create(:attempt, user: user, exercise: exercise_2, attempted_answer: exercise_2.answer)
      create(:attempt, user: user, exercise: exercise_3, attempted_answer: exercise_3.answer)
      create(:attempt, user: user, exercise: exercise_4, attempted_answer: exercise_3.answer)

      user.reload
      expect(user.learning_statuses.count).to eql(1)
      expect(
        user.learning_statuses.first.attributes
        .except('created_at', 'id', 'updated_at')
      ).to eql(
        'user_id' => user.id,
        'course_id' => course.id,
        'chapter_id' => chapter_2.id,
        'unit_id' => unit_3.id,
        'exercise_id' => exercise_5.id
      )
    end

    it 'update exercise 6, unit 3, chapter 2' do
      create(:attempt, user: user, exercise: exercise_1, attempted_answer: exercise_1.answer)
      create(:attempt, user: user, exercise: exercise_2, attempted_answer: exercise_2.answer)
      create(:attempt, user: user, exercise: exercise_3, attempted_answer: exercise_3.answer)
      create(:attempt, user: user, exercise: exercise_4, attempted_answer: exercise_3.answer)
      create(:attempt, user: user, exercise: exercise_5, attempted_answer: exercise_3.answer)

      user.reload
      expect(user.learning_statuses.count).to eql(1)
      expect(
        user.learning_statuses.first.attributes
        .except('created_at', 'id', 'updated_at')
      ).to eql(
        'user_id' => user.id,
        'course_id' => course.id,
        'chapter_id' => chapter_2.id,
        'unit_id' => unit_3.id,
        'exercise_id' => exercise_6.id
      )
    end

    it 'course_finished' do
      create(:attempt, user: user, exercise: exercise_1, attempted_answer: exercise_1.answer)
      create(:attempt, user: user, exercise: exercise_2, attempted_answer: exercise_2.answer)
      create(:attempt, user: user, exercise: exercise_3, attempted_answer: exercise_3.answer)
      create(:attempt, user: user, exercise: exercise_4, attempted_answer: exercise_3.answer)
      create(:attempt, user: user, exercise: exercise_5, attempted_answer: exercise_3.answer)
      last_attempt = create(:attempt, user: user, exercise: exercise_6, attempted_answer: exercise_3.answer)

      user.reload
      expect(user.learning_statuses.count).to eql(1)
      expect(
        user.learning_statuses.first.attributes
        .except('created_at', 'id', 'updated_at')
      ).to eql(
        'user_id' => user.id,
        'course_id' => course.id,
        'chapter_id' => chapter_2.id,
        'unit_id' => unit_3.id,
        'exercise_id' => exercise_6.id
      )

      expect(last_attempt.update_learning_status).to eql(:finished)
    end
  end
end
