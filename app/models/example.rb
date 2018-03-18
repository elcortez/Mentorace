class Example < ApplicationRecord
  belongs_to :lesson

  validate :unique_position_in_lesson
  validates_presence_of :content_en

  def unique_position_in_lesson
    return unless self.lesson.examples.pluck(:position_in_lesson).include?(self.position_in_lesson)
    errors.add(:position_in_lesson, 'already taken')
  end

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
end
