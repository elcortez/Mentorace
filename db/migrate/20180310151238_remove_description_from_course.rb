class RemoveDescriptionFromCourse < ActiveRecord::Migration[5.1]
  def change
    rename_column :courses, :title, :title_en
    rename_column :courses, :description, :description_en

    rename_column :chapters, :title, :title_en
    rename_column :chapters, :description, :description_en

    rename_column :units, :title, :title_en
    rename_column :examples, :content, :content_en
    rename_column :exercises, :question, :question_en
    rename_column :lessons, :content, :content_en
  end
end
