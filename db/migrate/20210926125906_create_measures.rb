class CreateMeasures < ActiveRecord::Migration[6.0]
  def change
    create_table :measures do |t|
      t.references :user
      t.string :title, null: false
      t.float :goal, null: false
      t.string :unit, null: false
      t.timestamps
    end
  end
end
