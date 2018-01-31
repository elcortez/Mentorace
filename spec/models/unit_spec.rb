require 'rails_helper'

RSpec.describe Unit, type: :model do
  describe '#is_available_for_user?' do
    let!(:user) { create(:user) }
    let!(:course) { create(:course, title: 'awesome title') }
    let!(:chapter) { create(:chapter, course: course, position_in_course: 1) }

    let!(:unit) { create(:unit, chapter: chapter, position_in_chapter: 1) }
    let!(:unit_exercise) { create(:unit_exercise, unit: unit, position_in_unit: 1) }

    it 'will return true if unit is the first of the first chapter' do
      expect(unit.is_available_for_user?(user)).to eql(true)
    end

    it 'will return false if it is on a later chapter' do
      chapter2 = create(:chapter, course: course, position_in_course: 2)
      unit_last = create(:unit, chapter: chapter2, position_in_chapter: 1)
      expect(unit_last.is_available_for_user?(user)).to eql(false)
    end

    it 'will return false if it is a later unit and not all exercises have been completed' do
      unit_last = create(:unit, chapter: chapter, position_in_chapter: 2)
      expect(unit_last.is_available_for_user?(user)).to eql(false)
    end

    it 'will return true if all exercises have been completed' do
      create(:exercise_attempt, user: user, unit_exercise: unit_exercise, attempted_answer: unit_exercise.answer)
      unit_last = create(:unit, chapter: chapter, position_in_chapter: 2)
      expect(unit_last.is_available_for_user?(user)).to eql(true)
    end
  end

  describe '.learning_elements' do
    let!(:course) { create(:course, title: 'awesome title') }
    let!(:chapter) { create(:chapter, course: course, position_in_course: 1) }
    let!(:unit) { create(:unit, chapter: chapter, position_in_chapter: 1) }
    let!(:unit_example) { create(:unit_example, unit: unit, position_in_unit: 1, content: 'content') }
    let!(:unit_image) { create(:unit_image, unit: unit, position_in_unit: 2, img_url: 'url') }
    let!(:unit_lesson) { create(:unit_lesson, unit: unit, position_in_unit: 3, content: 'content') }

    it 'can find its learning_elements' do
      unit.reload
      expect(unit.learning_elements.map(&:id)).to eql([
        unit_example.id, unit_image.id, unit_lesson.id
      ])
    end
  end

  describe 'validations' do
    let(:course) { create(:course, title: 'awesome title') }
    let(:chapter) { create(:chapter, course: course, position_in_course: 1) }

    it 'will refuse validation if no title' do
      unit = Unit.new(title: nil, chapter: chapter)
      expect(unit.save). to be false
      expect(unit.errors.messages).to eql(title: ["can't be blank"])

      unit.title = 'awesome unit title'
      expect(unit.save).to be true
    end

    it 'will not save if position_in_chapter is already taken' do
      create(:unit, chapter: chapter, position_in_chapter: 1)

      unit = Unit.new(title: 'title', chapter: chapter, position_in_chapter: 1)
      expect(unit.save).to be false
      expect(unit.errors.messages).to eql(position_in_chapter: ['already taken'])
    end
  end
end
