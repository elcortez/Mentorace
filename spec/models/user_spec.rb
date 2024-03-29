require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'model methods' do
    let!(:course) { create(:course) }
    let!(:chapter) { create(:chapter, course: course) }

    let!(:lesson) { create(:lesson, chapter: chapter) }
    let!(:exercise) { create(:exercise, lesson: lesson, position_in_lesson: 1) }
    let!(:exercise_2) { create(:exercise, lesson: lesson, position_in_lesson: 2) }
    let!(:lesson_2) { create(:lesson, chapter: chapter, position_in_chapter: 2) }
    let!(:exercise_3) { create(:exercise, lesson: lesson_2, position_in_lesson: 3) }

    let!(:chapter_2) { create(:chapter, course: course, position_in_course: 2) }
    let!(:lesson_3) { create(:lesson, chapter: chapter_2, position_in_chapter: 2) }
    let!(:exercise_4) { create(:exercise, lesson: lesson_3, position_in_lesson: 1) }

    let!(:user) { create(:user) }

    describe 'attempts_per_course' do
      it 'can return number of attempts for one course' do
        course_2 = create(:course)
        create(:attempt, user: user, exercise: exercise, attempted_answer: 'wrong answer')
        create(:attempt, user: user, exercise: exercise_2, attempted_answer: 'wrong answer')
        create(:attempt, user: user, exercise: exercise_3, attempted_answer: 'wrong answer')
        create(:attempt, user: user, exercise: exercise_4, attempted_answer: 'wrong answer')

        expect(user.attempts_number_per_course(course.id)).to eql(4)
        expect(user.attempts_number_per_course(course_2.id)).to eql(0)
      end
    end

    describe 'current_belts, current_belt_for_course, create_first_belts' do
      it 'create_first_belts' do
        expect(user.belts.count).to eql(1)
        expect(user.belts.first.course_id).to eql(course.id)
        expect(user.belts.first.level).to eql(1)
      end

      it 'current_belt_for_course' do
        expect(user.current_belt_for_course(course.id).level).to eql(1)
        create(:belt, user: user, course: course, level: 2)

        user.reload
        expect(user.current_belt_for_course(course.id).level).to eql(2)
      end

      it 'current_belts' do
        expect(user.current_belts.count).to eql(1)
        create(:belt, user: user, course: course, level: 2)

        user.reload
        expect(user.current_belts.count).to eql(1)
        expect(user.current_belts.last.level).to eql(2)
      end

      it 'current_belts with several courses' do
        expect(user.current_belts.count).to eql(1)
        create(:belt, user: user, course: course, level: 2)
        course_2 = create(:course)
        course_3 = create(:course)
        course_4 = create(:course)

        user.create_first_belts
        user.reload

        expect(user.belts.count).to eql(5)
        expect(user.current_belts.count).to eql(4)

        expect(user.current_belts.order(level: :desc)
          .map { |b| [b.level, b.course_id] })
          .to eql([
            [2, course.id],
            [1, course_2.id],
            [1, course_3.id],
            [1, course_4.id]
          ])
      end
    end

    describe '#has_finished_lesson?' do
      it 'has not finished any lesson' do
        expect(user.has_finished_lesson?(lesson)).to eql(false)
        expect(user.has_finished_lesson?(lesson_2)).to eql(false)
        expect(user.has_finished_lesson?(lesson_3)).to eql(false)
      end

      it 'has not finished any lesson with wrong attempts' do
        create(:attempt, user: user, exercise: exercise, attempted_answer: 'wrong answer')
        create(:attempt, user: user, exercise: exercise_2, attempted_answer: 'wrong answer')
        create(:attempt, user: user, exercise: exercise_3, attempted_answer: 'wrong answer')
        create(:attempt, user: user, exercise: exercise_4, attempted_answer: 'wrong answer')

        expect(user.has_finished_lesson?(lesson)).to eql(false)
        expect(user.has_finished_lesson?(lesson_2)).to eql(false)
        expect(user.has_finished_lesson?(lesson_3)).to eql(false)
      end

      it 'has not finished any lesson even with first exercise done' do
        create(:attempt, user: user, exercise: exercise, attempted_answer: exercise.answer)
        expect(user.has_finished_lesson?(lesson)).to eql(false)
        expect(user.has_finished_lesson?(lesson_2)).to eql(false)
        expect(user.has_finished_lesson?(lesson_3)).to eql(false)
      end

      it 'has finished lesson_1' do
        create(:attempt, user: user, exercise: exercise, attempted_answer: exercise.answer)
        create(:attempt, user: user, exercise: exercise_2, attempted_answer: exercise_2.answer)
        expect(user.has_finished_lesson?(lesson)).to eql(true)
        expect(user.has_finished_lesson?(lesson_2)).to eql(false)
        expect(user.has_finished_lesson?(lesson_3)).to eql(false)
      end

      it 'has finished lesson_2' do
        create(:attempt, user: user, exercise: exercise, attempted_answer: exercise.answer)
        create(:attempt, user: user, exercise: exercise_2, attempted_answer: exercise_2.answer)
        create(:attempt, user: user, exercise: exercise_3, attempted_answer: exercise_3.answer)
        expect(user.has_finished_lesson?(lesson)).to eql(true)
        expect(user.has_finished_lesson?(lesson_2)).to eql(true)
        expect(user.has_finished_lesson?(lesson_3)).to eql(false)
      end

      it 'has finished lesson_3' do
        create(:attempt, user: user, exercise: exercise, attempted_answer: exercise.answer)
        create(:attempt, user: user, exercise: exercise_2, attempted_answer: exercise_2.answer)
        create(:attempt, user: user, exercise: exercise_3, attempted_answer: exercise_3.answer)
        create(:attempt, user: user, exercise: exercise_4, attempted_answer: exercise_4.answer)

        expect(user.has_finished_lesson?(lesson)).to eql(true)
        expect(user.has_finished_lesson?(lesson_2)).to eql(true)
        expect(user.has_finished_lesson?(lesson_3)).to eql(true)
      end
    end

    describe '#can_access_lesson?' do
      it 'cannot access lesson if he has not finished previous exercises' do
        expect(user.can_access_lesson?(lesson)).to eql(true)
        expect(user.can_access_lesson?(lesson_2)).to eql(false)
        expect(user.can_access_lesson?(lesson_3)).to eql(false)
      end

      it 'cannot access lesson even with one of two finished' do
        create(:attempt, user: user, exercise: exercise, attempted_answer: exercise.answer)
        expect(user.can_access_lesson?(lesson)).to eql(true)
        expect(user.can_access_lesson?(lesson_2)).to eql(false)
        expect(user.can_access_lesson?(lesson_3)).to eql(false)
      end

      it 'can access lesson even with two of two finished' do
        create(:attempt, user: user, exercise: exercise, attempted_answer: exercise.answer)
        create(:attempt, user: user, exercise: exercise_2, attempted_answer: exercise_2.answer)

        expect(user.can_access_lesson?(lesson)).to eql(true)
        expect(user.can_access_lesson?(lesson_2)).to eql(true)
        expect(user.can_access_lesson?(lesson_3)).to eql(false)
      end

      it 'can access lesson_3' do
        create(:attempt, user: user, exercise: exercise, attempted_answer: exercise.answer)
        create(:attempt, user: user, exercise: exercise_2, attempted_answer: exercise_2.answer)
        create(:attempt, user: user, exercise: exercise_3, attempted_answer: exercise_3.answer)

        expect(user.can_access_lesson?(lesson)).to eql(true)
        expect(user.can_access_lesson?(lesson_2)).to eql(true)
        expect(user.can_access_lesson?(lesson_3)).to eql(true)
      end
    end

    describe '#has_finished_exercise?' do
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
    end

    describe '#can_access_exercise?' do
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
  end


  describe '#create_learning_statuses' do
    let!(:course) { create(:course) }
    let!(:chapter) { create(:chapter, course: course) }
    let!(:lesson) { create(:lesson, chapter: chapter) }
    let!(:exercise) { create(:exercise, lesson: lesson, position_in_lesson: 1) }

    it 'will automatically create a learning_status for each course' do
      user = create(:user)
      user.reload
      expect(user.learning_statuses.count).to eql(1)

      status = user.learning_statuses.first
      expect(status.attributes.except('created_at', 'id', 'updated_at')).to eql(
        'finished_at' => nil,
        'user_id' => user.id,
        'course_id' => course.id,
        'chapter_id' => chapter.id,
        'lesson_id' => lesson.id,
        'exercise_id' => exercise.id
      )
    end
  end
end
