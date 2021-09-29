class CreateReadings < ActiveRecord::Migration[6.0]
  def change
    create_table :readings do |t|
      t.decimal :fasting, null: false
      t.decimal :after_meal, null: false
      t.decimal :bp, null: false
      t.datetime :date, null: false
      t.references :user
      t.timestamps
    end
  end
end
