class CreateLessons < ActiveRecord::Migration[5.1]
  def change
    create_table :lessons do |t|
      t.references :chapter, foreign_key: true
      t.string :title_en
      t.text :content_en
      t.integer :position_in_chapter

      t.timestamps
    end
  end
end
