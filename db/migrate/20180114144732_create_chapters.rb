class CreateChapters < ActiveRecord::Migration[5.1]
  def change
    create_table :chapters do |t|
      t.references :course, foreign_key: true
      t.string :title_en
      t.string :description_en
      t.integer :position_in_course

      t.timestamps
    end
  end
end
