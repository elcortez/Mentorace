class RemoveDescriptionFromCourse < ActiveRecord::Migration[5.1]
  def change
    remove_column :courses, :description
  end
end
