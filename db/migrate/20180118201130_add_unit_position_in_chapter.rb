class AddUnitPositionInChapter < ActiveRecord::Migration[5.1]
  def change
    add_column :units, :position_in_chapter, :integer
  end
end
