class AddDatesToMedicines < ActiveRecord::Migration[7.1]
  def change
    add_column :medicines, :start_date, :date
    add_column :medicines, :end_date, :date
  end
end
