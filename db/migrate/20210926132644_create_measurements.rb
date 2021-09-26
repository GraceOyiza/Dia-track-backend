class CreateMeasurements < ActiveRecord::Migration[6.0]
  def change
    create_table :measurements do |t|
      t.references :measure
      t.float :value
      t.timestamps
    end
  end
end
