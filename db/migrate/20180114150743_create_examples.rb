class CreateExamples < ActiveRecord::Migration[5.1]
  def change
    create_table :examples do |t|
      t.references :lesson, foreign_key: true
      t.text :content_en
      t.string :img_url
      t.integer :position_in_lesson

      t.timestamps
    end
  end
end
