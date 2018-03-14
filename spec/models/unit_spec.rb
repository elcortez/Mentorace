require 'rails_helper'

RSpec.describe Unit, type: :model do
  describe 'validations / relations' do
    let(:course) { create(:course, title_en: 'awesome title_en') }
    let(:chapter) { create(:chapter, course: course, position_in_course: 1) }

    let!(:unit) { create(:unit, chapter: chapter, position_in_chapter: 1) }
    let!(:unit_2) { create(:unit, chapter: chapter, position_in_chapter: 2) }
    let!(:unit_3) { create(:unit, chapter: chapter, position_in_chapter: 3) }

    it 'has_one :next_unit_in_chapter' do
      expect(unit.next_unit_in_chapter.id).to eql(unit_2.id)
      expect(unit_2.next_unit_in_chapter.id).to eql(unit_3.id)
      expect(unit_3.next_unit_in_chapter).to eql(nil)
    end

    it 'has_one :previous_unit_in_chapter' do
      expect(unit.previous_unit_in_chapter).to eql(nil)
      expect(unit_2.previous_unit_in_chapter.id).to eql(unit.id)
      expect(unit_3.previous_unit_in_chapter.id).to eql(unit_2.id)
    end

    it 'will refuse validation if no title_en' do
      unit = Unit.new(title_en: nil, chapter: chapter)
      expect(unit.save). to be false
      expect(unit.errors.messages).to eql(title_en: ["can't be blank"])

      unit.title_en = 'awesome unit title_en'
      expect(unit.save).to be true
    end

    it 'will not save if position_in_chapter is already taken' do
      wrong_unit = Unit.new(title_en: 'title_en', chapter: chapter, position_in_chapter: 1)
      expect(wrong_unit.save).to be false
      expect(wrong_unit.errors.messages).to eql(position_in_chapter: ['already taken'])
    end
  end
end
