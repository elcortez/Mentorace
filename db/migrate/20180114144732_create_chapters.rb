class CreateChapters < ActiveRecord::Migration[5.1]
  def change
    create_table :chapters do |t|
      t.references :course, foreign_key: true
      t.string :title
      t.string :description

      t.timestamps
    end
  end
end
