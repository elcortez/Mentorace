class CreateCourses < ActiveRecord::Migration[5.1]
  def change
    create_table :courses do |t|
      t.string :title_en
      t.string :description_en

      t.timestamps
    end
  end
end
