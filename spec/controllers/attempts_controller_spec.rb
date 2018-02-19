require 'rails_helper'

RSpec.describe AttemptsController, type: :controller do
  describe 'new / create' do
    let!(:course) { create(:course) }
    let!(:chapter) { create(:chapter, course: course) }
    let!(:unit) { create(:unit, chapter: chapter) }
    let!(:exercise) { create(:exercise, unit: unit, position_in_unit: 1) }
    let!(:exercise_2) { create(:exercise, unit: unit, position_in_unit: 2) }
    let!(:exercise_3) { create(:exercise, unit: unit, position_in_unit: 3) }

    let!(:user) { create(:user) }
    let!(:user_two) { create(:user, email: 'other@gmail.com') }

    before do
      allow(controller).to receive(:authenticate_user!)
      allow(controller).to receive(:current_user) { user }
    end

    it 'will always redirect to the first unit exercise that has not yet been validated' do
      response = get :new, params: {
        course_id: course.id,
        chapter_id: chapter.id,
        unit_id: unit.id,
        exercise_id: exercise_2.id
      }

      expect(response).to redirect_to new_course_chapter_unit_exercise_attempt_path(
        course_id: course.id,
        chapter_id: chapter.id,
        unit_id: unit.id,
        exercise_id: exercise.id
      )
    end

    it 'will redirect to the first unit exercise that has not yet been validated' do
      response = get :new, params: {
        course_id: course.id,
        chapter_id: chapter.id,
        unit_id: unit.id,
        exercise_id: exercise_3.id
      }

      expect(response).to redirect_to new_course_chapter_unit_exercise_attempt_path(
        course_id: course.id,
        chapter_id: chapter.id,
        unit_id: unit.id,
        exercise_id: exercise.id
      )
    end

    it 'will redirect to the first unit exercise that has not yet been validated even if another one is validated' do
      create(:attempt, user: user, exercise: exercise, attempted_answer: exercise.answer)

      response = get :new, params: {
        course_id: course.id,
        chapter_id: chapter.id,
        unit_id: unit.id,
        exercise_id: exercise_3.id
      }

      expect(response).to redirect_to new_course_chapter_unit_exercise_attempt_path(
        course_id: course.id,
        chapter_id: chapter.id,
        unit_id: unit.id,
        exercise_id: exercise_2.id
      )
    end

    it 'will render good view if it is the first exercise' do
      response = get :new, params: {
        course_id: course.id,
        chapter_id: chapter.id,
        unit_id: unit.id,
        exercise_id: exercise.id
      }

      expect(response.code).to eql('200')
    end

    it 'will render good view if previous exercise has been validated' do
      create(:attempt, user: user, exercise: exercise, attempted_answer: exercise.answer)
      response = get :new, params: {
        course_id: course.id,
        chapter_id: chapter.id,
        unit_id: unit.id,
        exercise_id: exercise_2.id
      }

      expect(response.code).to eql('200')
    end

    it 'will render good view if all previous exercises have been validated' do
      create(:attempt, user: user, exercise: exercise, attempted_answer: exercise.answer)
      create(:attempt, user: user, exercise: exercise_2, attempted_answer: exercise_2.answer)

      response = get :new, params: {
        course_id: course.id,
        chapter_id: chapter.id,
        unit_id: unit.id,
        exercise_id: exercise_3.id
      }

      expect(response.code).to eql('200')
    end

    # it 'in case of a post, it will save attempt && redirect to same exercise if it is a wrong answer' do
    # end
    #
    # it 'will redirect to the next exercise if attempt is successful' do
    # end
  end
end
