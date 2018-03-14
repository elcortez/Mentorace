require 'rails_helper'

RSpec.describe Exercise, type: :model do
  describe 'validations / relations' do
    let!(:course_0) { create(:course) }

    let!(:chapter_0) { create(:chapter, course: course_0, position_in_course: 1) }
    let!(:lesson_0) { create(:lesson, chapter: chapter_0, position_in_chapter: 1) }
    let!(:exercise_0) { create(:exercise, lesson: lesson_0, position_in_lesson: 1) }

    let!(:course) { create(:course) }

    let!(:chapter) { create(:chapter, course: course, position_in_course: 1) }
    let!(:lesson) { create(:lesson, chapter: chapter, position_in_chapter: 1) }
    let!(:exercise_1) { create(:exercise, lesson: lesson, position_in_lesson: 1) }
    let!(:exercise_2) { create(:exercise, lesson: lesson, position_in_lesson: 2) }
    let!(:lesson_2) { create(:lesson, chapter: chapter, position_in_chapter: 2) }
    let!(:exercise_3) { create(:exercise, lesson: lesson_2, position_in_lesson: 1) }
    let!(:exercise_4) { create(:exercise, lesson: lesson_2, position_in_lesson: 2) }

    let!(:chapter_2) { create(:chapter, course: course, position_in_course: 2) }
    let!(:lesson_3) { create(:lesson, chapter: chapter_2, position_in_chapter: 1) }
    let!(:exercise_5) { create(:exercise, lesson: lesson_3, position_in_lesson: 1) }
    let!(:exercise_6) { create(:exercise, lesson: lesson_3, position_in_lesson: 2) }

    it 'has_one :previous_exercise' do
      expect(exercise_0.previous_exercise).to eql(nil)

      expect(exercise_1.previous_exercise).to eql(nil)
      expect(exercise_2.previous_exercise.id).to eql(exercise_1.id)
      expect(exercise_3.previous_exercise.id).to eql(exercise_2.id)
      expect(exercise_4.previous_exercise.id).to eql(exercise_3.id)
      expect(exercise_5.previous_exercise.id).to eql(exercise_4.id)
      expect(exercise_6.previous_exercise.id).to eql(exercise_5.id)
    end

    it 'has_one :next_exercise_in_lesson' do
      expect(exercise_1.next_exercise_in_lesson.id).to eql(exercise_2.id)
      expect(exercise_2.next_exercise_in_lesson).to eql(nil)
    end

    it 'has_one :previous_exercise_in_lesson' do
      expect(exercise_1.previous_exercise_in_lesson).to eql(nil)
      expect(exercise_2.previous_exercise_in_lesson.id).to eql(exercise_1.id)
    end

    it '#unique_exercise_position_in_lesson' do
      exercise_2 = Exercise.new(lesson: lesson, position_in_lesson: 1)
      expect(exercise_2.save).to eql(false)
      expect(exercise_2.errors.messages).to eql(position_in_lesson: ['already taken'])
    end
  end
end
