require 'rails_helper'

RSpec.describe Image, type: :model do
  describe 'validations' do
    let!(:course) { create(:course, title: 'awesome title') }
    let!(:chapter) { create(:chapter, course: course, position_in_course: 1, title: 'title') }
    let!(:unit) { create(:unit, chapter: chapter, position_in_chapter: 1, title: 'title') }
    let!(:image) { create(:image, unit: unit, img_url: 'img_url', position_in_unit: 1) }

    it 'will not save if position_in_unit is already taken' do
      unit.reload
      image.reload

      image_2 = Image.new(unit: unit, position_in_unit: 1, img_url: 'img_url')

      expect(image_2.save).to be false
      expect(image_2.errors.messages).to eql(position_in_unit: ['already taken'])
    end
  end
end
