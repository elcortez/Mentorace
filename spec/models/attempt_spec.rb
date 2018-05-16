require 'rails_helper'

RSpec.describe Attempt, type: :model do
  describe '#give_experience' do
    let!(:exercise) { create(:exercise,
      question_en: double('question'),
      lesson: create(:lesson, chapter: create(:chapter, course: create(:course))),
      answer: '123'
    ) }

    let!(:user) { create(:user) }

    it 'will give experience if it is the first successful' do
      expect(user.belts.first.current_experience).to eql(0)

      create(:attempt, exercise: exercise, attempted_answer: '123', user: user)
    end

    it 'will not give experience if there has been a successful experience before' do
    end

    it 'will create a new belt if the experience it gives reaches beyond max_xp of current belt' do
    end
  end

  describe '#set_successful' do
    let!(:exercise) { create(:exercise,
      question_en: double('question'),
      lesson: create(:lesson, chapter: create(:chapter, course: create(:course))),
      answer: '123'
    ) }

    let!(:user) { create(:user) }
    let!(:successful_attempt) { create(:attempt,
      exercise: exercise, attempted_answer: '123', user: user) }

    let!(:successful_attempt_with_spaces) { create(:attempt,
      exercise: exercise, attempted_answer: ' 1 2 3 ', user: user) }

    let!(:failed_attempt) { create(:attempt,
      exercise: exercise, attempted_answer: '1234', user: user) }

    it 'sets successful and failure on create' do
      expect(successful_attempt.attempt_successful).to eql(true)
      expect(failed_attempt.attempt_successful).to eql(false)
      expect(successful_attempt_with_spaces.attempt_successful).to eql(true)
    end
  end

  describe '#update_learning_status' do
    let!(:course) { create(:course) }

    let!(:chapter_1) { create(:chapter, course: course) }
    let!(:lesson_1) { create(:lesson, chapter: chapter_1) }
    let!(:exercise_1) { create(:exercise, lesson: lesson_1) }
    let!(:exercise_2) { create(:exercise, lesson: lesson_1, position_in_lesson: 2) }

    let!(:lesson_2) { create(:lesson, chapter: chapter_1, position_in_chapter: 2) }
    let!(:exercise_3) { create(:exercise, lesson: lesson_2) }
    let!(:exercise_4) { create(:exercise, lesson: lesson_2, position_in_lesson: 2) }

    let!(:chapter_2) { create(:chapter, course: course, position_in_course: 2) }
    let!(:lesson_3) { create(:lesson, chapter: chapter_2, position_in_chapter: 3) }
    let!(:exercise_5) { create(:exercise, lesson: lesson_3) }
    let!(:exercise_6) { create(:exercise, lesson: lesson_3, position_in_lesson: 2) }

    let!(:user) { create(:user) }

    it 'basic learning_status' do
      expect(user.learning_statuses.count).to eql(1)
      expect(
        user.learning_statuses.first.attributes
        .except('created_at', 'id', 'updated_at')
      ).to eql(
        'finished_at' => nil,
        'user_id' => user.id,
        'course_id' => course.id,
        'chapter_id' => chapter_1.id,
        'lesson_id' => lesson_1.id,
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
        'finished_at' => nil,
        'user_id' => user.id,
        'course_id' => course.id,
        'chapter_id' => chapter_1.id,
        'lesson_id' => lesson_1.id,
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
        'finished_at' => nil,
        'user_id' => user.id,
        'course_id' => course.id,
        'chapter_id' => chapter_1.id,
        'lesson_id' => lesson_1.id,
        'exercise_id' => exercise_2.id
      )
    end

    it 'update exercise 3, lesson 2' do
      create(:attempt, user: user, exercise: exercise_1, attempted_answer: exercise_1.answer)
      create(:attempt, user: user, exercise: exercise_2, attempted_answer: exercise_2.answer)

      user.reload
      expect(user.learning_statuses.count).to eql(1)
      expect(
        user.learning_statuses.first.attributes
        .except('created_at', 'id', 'updated_at')
      ).to eql(
        'finished_at' => nil,
        'user_id' => user.id,
        'course_id' => course.id,
        'chapter_id' => chapter_1.id,
        'lesson_id' => lesson_2.id,
        'exercise_id' => exercise_3.id
      )
    end

    it 'update exercise 4, lesson 2' do
      create(:attempt, user: user, exercise: exercise_1, attempted_answer: exercise_1.answer)
      create(:attempt, user: user, exercise: exercise_2, attempted_answer: exercise_2.answer)
      create(:attempt, user: user, exercise: exercise_3, attempted_answer: exercise_3.answer)

      user.reload
      expect(user.learning_statuses.count).to eql(1)
      expect(
        user.learning_statuses.first.attributes
        .except('created_at', 'id', 'updated_at')
      ).to eql(
        'finished_at' => nil,
        'user_id' => user.id,
        'course_id' => course.id,
        'chapter_id' => chapter_1.id,
        'lesson_id' => lesson_2.id,
        'exercise_id' => exercise_4.id
      )
    end

    it 'update exercise 5, lesson 3, chapter 2' do
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
        'finished_at' => nil,
        'user_id' => user.id,
        'course_id' => course.id,
        'chapter_id' => chapter_2.id,
        'lesson_id' => lesson_3.id,
        'exercise_id' => exercise_5.id
      )
    end

    it 'update exercise 6, lesson 3, chapter 2' do
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
        'finished_at' => nil,
        'user_id' => user.id,
        'course_id' => course.id,
        'chapter_id' => chapter_2.id,
        'lesson_id' => lesson_3.id,
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
        .except('created_at', 'id', 'updated_at', 'finished_at')
      ).to eql(
        'user_id' => user.id,
        'course_id' => course.id,
        'chapter_id' => chapter_2.id,
        'lesson_id' => lesson_3.id,
        'exercise_id' => exercise_6.id
      )

      expect(user.learning_statuses.first.finished_at.class).to eql(ActiveSupport::TimeWithZone)
    end
  end
end
