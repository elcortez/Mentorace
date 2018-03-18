require 'rails_helper'

RSpec.describe Example, type: :model do

  describe 'display_content' do
    let(:course) { create(:course, title_en: 'awesome title_en') }
    let(:chapter) { create(:chapter, course: course, position_in_course: 1) }
    let!(:lesson) { create(:lesson, chapter: chapter, title_en: 'title', content_en: 'content')}

    let!(:example) { create(:example,
      lesson: lesson,
      content_en: "## This is your lesson \n" \
        "Make good use of it \n\n" \
        "* You can have bullet points \n\n" \
        "* You can have lots of them \n\n" \
        "and then return."
    ) }

    it 'can display content in html' do
      expect(example.display_content).to eql(
        "<h2>This is your lesson</h2>\n\n"\
        "<p>Make good use of it </p>\n\n"\
        "<ul>\n<li><p>You can have bullet points </p></li>\n"\
        "<li><p>You can have lots of them </p></li>\n"\
        "</ul>\n\n<p>and then return.</p>\n"
      )
    end
  end

  describe 'validations' do
    let!(:course) { create(:course, title_en: 'awesome title_en') }
    let!(:chapter) { create(:chapter, course: course, position_in_course: 1, title_en: 'title_en') }
    let!(:lesson) { create(:lesson, chapter: chapter, position_in_chapter: 1, title_en: 'title_en') }
    let!(:example) { create(:example, lesson: lesson, content_en: 'content', position_in_lesson: 1) }

    it 'will not save if position_in_lesson is already taken' do
      lesson.reload
      example.reload

      example_2 = Example.new(lesson: lesson, position_in_lesson: 1, content_en: 'content')

      expect(example_2.save).to be false
      expect(example_2.errors.messages).to eql(position_in_lesson: ['already taken'])
    end
  end
end
