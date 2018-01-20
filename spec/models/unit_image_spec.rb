require 'rails_helper'

RSpec.describe UnitImage, type: :model do
  describe 'validations' do
    let!(:course) { create(:course, title: 'awesome title') }
    let!(:chapter) { create(:chapter, course: course, position_in_course: 1, title: 'title') }
    let!(:unit) { create(:unit, chapter: chapter, position_in_chapter: 1, title: 'title') }
    let!(:unit_image) { create(:unit_image, unit: unit, img_url: 'img_url', position_in_unit: 1) }

    it 'will not save if position_in_unit is already taken' do
      unit.reload
      unit_image.reload

      unit_image_2 = UnitImage.new(unit: unit, position_in_unit: 1, img_url: 'img_url')

      expect(unit_image_2.save).to be false
      expect(unit_image_2.errors.messages).to eql(position_in_unit: ['already taken'])
    end
  end
end
