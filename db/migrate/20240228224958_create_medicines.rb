class CreateMedicines < ActiveRecord::Migration[7.1]
  def change
    create_table :medicines do |t|
      t.string :name
      t.string :dosage
      t.integer :times_a_day
      t.integer :duration
      t.string :recommended_by
      t.references :patient, null: false, foreign_key: true

      t.timestamps
    end
  end
end
