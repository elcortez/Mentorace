class CreateUnits < ActiveRecord::Migration[5.1]
  def change
    create_table :units do |t|
      t.references :chapter, foreign_key: true
      t.string :title

      t.timestamps
    end
  end
end
