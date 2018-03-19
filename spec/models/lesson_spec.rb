require 'rails_helper'

RSpec.describe Lesson, type: :model do
  describe 'display_content' do
    let(:course) { create(:course, title_en: 'awesome title_en') }
    let(:chapter) { create(:chapter, course: course, position_in_course: 1) }

    let!(:lesson) { create(:lesson,
      chapter: chapter,
      title_en: 'Specs lesson',
      content_en: "## This is your lesson \n" \
        "Make good use of it \n\n" \
        "* You can have bullet points \n\n" \
        "* You can have lots of them \n\n" \
        "and then return."
    ) }

    it 'can display content in html' do
      expect(lesson.display_content).to eql(
        "<h2>This is your lesson</h2>\n\n"\
        "<p>Make good use of it </p>\n\n"\
        "<ul>\n<li><p>You can have bullet points </p></li>\n"\
        "<li><p>You can have lots of them </p></li>\n"\
        "</ul>\n\n<p>and then return.</p>\n"
      )
    end
  end

  describe 'validations / relations' do
    let(:course) { create(:course, title_en: 'awesome title_en') }
    let(:chapter) { create(:chapter, course: course, position_in_course: 1) }

    let!(:lesson) { create(:lesson, chapter: chapter, position_in_chapter: 1) }
    let!(:lesson_2) { create(:lesson, chapter: chapter, position_in_chapter: 2) }
    let!(:lesson_3) { create(:lesson, chapter: chapter, position_in_chapter: 3) }

    let!(:chapter_2) { create(:chapter, course: course, position_in_course: 2) }
    let!(:lesson_4) { create(:lesson, chapter: chapter_2, position_in_chapter: 1) }

    let!(:chapter_3) { create(:chapter, course: course, position_in_course: 3) }
    let!(:lesson_5) { create(:lesson, chapter: chapter_3, position_in_chapter: 1) }

    it 'has_one :next_lesson_in_chapter' do
      expect(lesson.next_lesson_in_chapter.id).to eql(lesson_2.id)
      expect(lesson_2.next_lesson_in_chapter.id).to eql(lesson_3.id)
      expect(lesson_3.next_lesson_in_chapter).to eql(nil)
    end

    it 'has_one :previous_lesson_in_chapter' do
      expect(lesson.previous_lesson_in_chapter).to eql(nil)
      expect(lesson_2.previous_lesson_in_chapter.id).to eql(lesson.id)
      expect(lesson_3.previous_lesson_in_chapter.id).to eql(lesson_2.id)
    end

    it 'previous_lesson' do
      expect(lesson_5.previous_lesson.id).to eql(lesson_4.id)
      expect(lesson_4.previous_lesson.id).to eql(lesson_3.id)
      expect(lesson_3.previous_lesson.id).to eql(lesson_2.id)
      expect(lesson_2.previous_lesson.id).to eql(lesson.id)
      expect(lesson.previous_lesson).to eql(nil)
    end

    it 'will refuse validation if no title_en' do
      lesson = Lesson.new(title_en: nil, chapter: chapter)
      expect(lesson.save). to be false
      expect(lesson.errors.messages).to eql(title_en: ["can't be blank"])

      lesson.title_en = 'awesome lesson title_en'
      expect(lesson.save).to be true
    end

    it 'will not save if position_in_chapter is already taken' do
      wrong_lesson = Lesson.new(title_en: 'title_en', chapter: chapter, position_in_chapter: 1)
      expect(wrong_lesson.save).to be false
      expect(wrong_lesson.errors.messages).to eql(position_in_chapter: ['already taken'])
    end
  end
end
