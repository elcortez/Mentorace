require 'rails_helper'

RSpec.describe ExerciseAttemptsController, type: :controller do
  describe 'new / create' do
    let!(:user) { create(:user) }
    let!(:course) { create(:course) }
    let!(:chapter) { create(:chapter, course: course) }
    let!(:unit) { create(:unit, chapter: chapter) }
    let!(:unit_exercise) { create(:unit_exercise, unit: unit, position_in_unit: 1) }
    let!(:unit_exercise_2) { create(:unit_exercise, unit: unit, position_in_unit: 2) }
    let!(:unit_exercise_3) { create(:unit_exercise, unit: unit, position_in_unit: 3) }

    before do
      allow(controller).to receive(:authenticate_user!)
      allow(controller).to receive(:current_user) { current_user }
    end

    it 'will always redirect to the first unit exercise that has not yet been validated' do
      response = get :new, params: {
        course_id: course.id,
        chapter_id: chapter.id,
        unit_id: unit.id,
        unit_exercise_id: unit_exercise_2.id
      }

      # Parameters: {"course_id"=>"1", "chapter_id"=>"1", "unit_id"=>"2", "unit_exercise_id"=>"4"}

      # expect(response).to redirect_to(:back)
      expect(response).to redirect_to new_course_chapter_unit_unit_exercise_exercise_attempt_path(
        course_id: course.id,
        chapter_id: chapter.id,
        unit_id: unit.id,
        unit_exercise_id: unit_exercise.id

      )
    end

    # it 'in case of a post, it will save attempt && redirect to same exercise if it is a wrong answer' do
    # end
    #
    # it 'will redirect to the next exercise if attempt is successful' do
    # end
  end
end
