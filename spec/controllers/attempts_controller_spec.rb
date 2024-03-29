require 'rails_helper'

RSpec.describe AttemptsController, type: :controller do
  describe 'new / create' do
    let!(:course) { create(:course) }

    let!(:chapter) { create(:chapter, course: course, position_in_course: 1) }

    let!(:lesson) { create(:lesson, chapter: chapter, position_in_chapter: 1) }
    let!(:exercise) { create(:exercise, lesson: lesson, position_in_lesson: 1) }
    let!(:exercise_2) { create(:exercise, lesson: lesson, position_in_lesson: 2) }
    let!(:exercise_3) { create(:exercise, lesson: lesson, position_in_lesson: 3) }

    let!(:lesson_2) { create(:lesson, chapter: chapter, position_in_chapter: 2) }
    let!(:exercise_4) { create(:exercise, lesson: lesson_2, position_in_lesson: 1) }
    let!(:exercise_5) { create(:exercise, lesson: lesson_2, position_in_lesson: 2) }


    let!(:chapter_2) { create(:chapter, course: course, position_in_course: 2) }

    let!(:lesson_3) { create(:lesson, chapter: chapter_2, position_in_chapter: 2) }
    let!(:exercise_6) { create(:exercise, lesson: lesson_3, position_in_lesson: 1) }
    let!(:exercise_7) { create(:exercise, lesson: lesson_3, position_in_lesson: 2) }

    let!(:user) { create(:user) }
    let!(:user_two) { create(:user, email: 'other@gmail.com') }

    let(:basic_params) { {
      course_id: course.id,
      chapter_id: chapter.id,
      lesson_id: lesson.id
    } }

    before do
      allow(controller).to receive(:authenticate_user!)
      allow(controller).to receive(:current_user) { user }
    end

    describe 'create' do
      it 'will redirect to course index if last exercise && successful' do
        [exercise, exercise_2, exercise_3, exercise_4, exercise_5, exercise_6].each do |exo|
          create(:attempt, user_id: user.id, exercise_id: exo.id, attempted_answer: exo.answer)
        end

        response = post :create, params: {
          attempt: { attempted_answer: exercise_7.answer, exercise_id: exercise_7.id },
          exercise_id: exercise_7.id,
          lesson_id: lesson_3.id,
          chapter_id: chapter_2.id,
          course_id: course.id
        }

        expect(response).to redirect_to courses_path
      end

      it 'even if every exercise is over, user can still go up to the top' do
        [exercise, exercise_2, exercise_3, exercise_4, exercise_5, exercise_6, exercise_7].each do |exo|
          create(:attempt, user_id: user.id, exercise_id: exo.id, attempted_answer: exo.answer)
        end

        response = post :create, params: {
          attempt: { attempted_answer: exercise_6.answer, exercise_id: exercise_6.id },
          exercise_id: exercise_6.id,
          lesson_id: lesson_3.id,
          chapter_id: chapter_2.id,
          course_id: course.id
        }

        expect(response).to redirect_to new_course_chapter_lesson_exercise_attempt_path(
          exercise_id: exercise_7.id,
          lesson_id: lesson_3.id,
          chapter_id: chapter_2.id,
          course_id: course.id
        )
      end

      it 'will redirect to next chapter if it was the last lesson of the chapter' do
        [exercise, exercise_2, exercise_3, exercise_4].each do |exo|
          create(:attempt, user_id: user.id, exercise_id: exo.id, attempted_answer: exo.answer)
        end

        response = post :create, params: {
          attempt: { attempted_answer: exercise_5.answer, exercise_id: exercise_5.id },
          exercise_id: exercise_5.id,
          lesson_id: lesson_2.id,
          chapter_id: chapter.id,
          course_id: course.id
        }

        expect(response).to redirect_to course_chapter_lesson_path(
          course_id: course.id, chapter_id: chapter_2.id, id: lesson_3.id
        )
      end

      it 'will redirect to next lesson if it was the last exercise of the lesson' do
        [exercise, exercise_2].each do |exo|
          create(:attempt, user_id: user.id, exercise_id: exo.id, attempted_answer: exo.answer)
        end

        response = post :create, params: {
          attempt: { attempted_answer: exercise_3.answer, exercise_id: exercise_3.id },
          exercise_id: exercise_3.id,
          lesson_id: lesson.id,
          chapter_id: chapter.id,
          course_id: course.id
        }

        expect(response).to redirect_to course_chapter_lesson_path(
          course_id: course.id, chapter_id: chapter.id, id: lesson_2.id
        )
      end

      it 'will redirect to the next exercise if attempt is successful' do
        expect(user.attempts.count).to eql(0)

        response = post :create, params: basic_params.merge(
          exercise_id: exercise.id,
          attempt: { attempted_answer: exercise.answer, exercise_id: exercise.id }
        )

        expect(response).to redirect_to new_course_chapter_lesson_exercise_attempt_path(
          basic_params.merge(exercise_id: exercise_2.id)
        )
        user.reload
        expect(user.attempts.count).to eql(1)
        expect(user.attempts.first.attempt_successful).to eql(true)

        response = post :create, params: basic_params.merge(
          exercise_id: exercise_2.id,
          attempt: { attempted_answer: exercise_2.answer, exercise_id: exercise_2.id }
        )

        expect(response).to redirect_to new_course_chapter_lesson_exercise_attempt_path(
          basic_params.merge(exercise_id: exercise_3.id)
        )

        user.reload
        expect(user.attempts.count).to eql(2)
        expect(user.attempts.find_by(exercise_id: exercise_2.id).attempt_successful).to eql(true)
      end

      it 'will redirect to first exercise if user should not have access to exercise' do
        response = post :create, params: basic_params.merge(
          exercise_id: exercise_2.id,
          attempt: { attempted_answer: exercise_2.answer, exercise_id: exercise_2.id }
        )

        expect(response).to redirect_to new_course_chapter_lesson_exercise_attempt_path(
          basic_params.merge(exercise_id: exercise.id)
        )
      end

      it 'it will save && redirect to same exercise if it is a wrong answer' do
        expect(user.attempts.count).to eql(0)

        response = post :create, params: basic_params.merge(
          exercise_id: exercise.id,
          attempt: { attempted_answer: 'wrong answer', exercise_id: exercise.id }
        )

        expect(response).to redirect_to new_course_chapter_lesson_exercise_attempt_path(
          basic_params.merge(exercise_id: exercise.id)
        )
        user.reload
        expect(user.attempts.count).to eql(1)
      end

      it 'user can create as many attempts as she wishes on same exercise' do
        create(:attempt, user: user, exercise: exercise, attempted_answer: exercise.answer)
        user.reload
        expect(user.attempts.count).to eql(1)

        response = post :create, params: basic_params.merge(
          exercise_id: exercise.id,
          attempt: { attempted_answer: exercise.answer, exercise_id: exercise.id }
        )

        expect(response).to redirect_to new_course_chapter_lesson_exercise_attempt_path(
          basic_params.merge(exercise_id: exercise_2.id)
        )

        user.reload
        expect(user.attempts.pluck(:exercise_id, :user_id, :attempted_answer, :attempt_successful))
          .to eql([
            [exercise.id, user.id, exercise.answer, true],
            [exercise.id, user.id, exercise.answer, true]
          ])
      end
    end

    describe 'new' do
      it 'will always redirect to the first lesson exercise that has not yet been validated' do
        response = get :new, params: basic_params.merge(exercise_id: exercise_2.id)
        expect(response).to redirect_to new_course_chapter_lesson_exercise_attempt_path(
          basic_params.merge(exercise_id: exercise.id)
        )
      end

      it 'will redirect to the first lesson exercise that has not yet been validated even if exercise is further away' do
        response = get :new, params: basic_params.merge(exercise_id: exercise_3.id)
        expect(response).to redirect_to new_course_chapter_lesson_exercise_attempt_path(
          basic_params.merge(exercise_id: exercise.id)
        )
      end

      it 'will redirect to the first lesson exercise that has not yet been validated even if another one is validated' do
        create(:attempt, user: user, exercise: exercise, attempted_answer: exercise.answer)

        response = get :new, params: basic_params.merge(exercise_id: exercise_3.id)
        expect(response).to redirect_to new_course_chapter_lesson_exercise_attempt_path(
          basic_params.merge(exercise_id: exercise_2.id)
        )
      end

      it 'will render good view if it is the first exercise' do
        expect(Attempt).to receive(:new)
        response = get :new, params: basic_params.merge(exercise_id: exercise.id)
        expect(response.code).to eql('200')
      end

      it 'will render good view if previous exercise has been validated' do
        create(:attempt, user: user, exercise: exercise, attempted_answer: exercise.answer)

        expect(Attempt).to receive(:new)
        response = get :new, params: basic_params.merge(exercise_id: exercise_2.id)

        expect(response.code).to eql('200')
      end

      it 'can access exercise 1 even if already validated' do
        create(:attempt, user: user, exercise: exercise, attempted_answer: exercise.answer)
        create(:attempt, user: user, exercise: exercise_2, attempted_answer: exercise_2.answer)

        expect(Attempt).to receive(:new)
        response = get :new, params: basic_params.merge(exercise_id: exercise_3.id)
        expect(response.code).to eql('200')
      end

      it 'can access exercise 2 even if already validated' do
        create(:attempt, user: user, exercise: exercise, attempted_answer: exercise.answer)
        create(:attempt, user: user, exercise: exercise_2, attempted_answer: exercise_2.answer)

        expect(Attempt).to receive(:new)
        response = get :new, params: basic_params.merge(exercise_id: exercise_3.id)
        expect(response.code).to eql('200')
      end

      it 'can access exercise 3 even if already validated' do
        create(:attempt, user: user, exercise: exercise, attempted_answer: exercise.answer)
        create(:attempt, user: user, exercise: exercise_2, attempted_answer: exercise_2.answer)
        create(:attempt, user: user, exercise: exercise_3, attempted_answer: exercise_2.answer)

        expect(Attempt).to receive(:new)
        response = get :new, params: basic_params.merge(exercise_id: exercise_3.id)
        expect(response.code).to eql('200')
      end

      it 'will render good view if all previous exercises have been validated' do
        create(:attempt, user: user, exercise: exercise, attempted_answer: exercise.answer)
        create(:attempt, user: user, exercise: exercise_2, attempted_answer: exercise_2.answer)

        expect(Attempt).to receive(:new)
        response = get :new, params: basic_params.merge(exercise_id: exercise_3.id)
        expect(response.code).to eql('200')
      end
    end
  end
end
