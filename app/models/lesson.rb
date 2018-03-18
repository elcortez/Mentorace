class Lesson < ApplicationRecord
  belongs_to :chapter
  validates_presence_of :title_en
  validate :unique_position_in_chapter

  has_many :examples
  has_many :exercises
  has_one :learning_status

  has_one :next_lesson_in_chapter, -> (lesson) {
    where(
      position_in_chapter: lesson.position_in_chapter + 1,
      chapter_id: lesson.chapter_id
    ).limit(1)
  }, through: :chapter, source: :lessons

  has_one :previous_lesson_in_chapter, -> (lesson) {
    where(
      position_in_chapter: lesson.position_in_chapter - 1,
      chapter_id: lesson.chapter_id
    ).limit(1)
  }, through: :chapter, source: :lessons

  def display_content(locale = :en)
    # Markdown rules : https://github.com/vmg/redcarpet
    raw_content = self.send("content_#{locale}")

    mardown = Redcarpet::Markdown.new(
      Redcarpet::Render::HTML,
      autolink: true,
      tables: true,
      space_after_headers: true,
      hard_wrap: true
    )

    mardown.render(raw_content)
  end

  def exercises_ordered
    self.exercises.order(:position_in_lesson)
  end

  def unique_position_in_chapter
    return unless self.chapter.lessons.pluck(:position_in_chapter).include?(self.position_in_chapter)
    errors.add(:position_in_chapter, 'already taken')
  end
end
