class CreateBelts < ActiveRecord::Migration[5.1]
  def change
    create_table :belts do |t|
      t.references :user, foreign_key: true
      t.references :course, foreign_key: true
      t.integer :level
      t.integer :current_xp, default: 0
      t.integer :max_xp

      t.timestamps
    end
  end
end
