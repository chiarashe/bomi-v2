class AddDateToReports < ActiveRecord::Migration[7.1]
  def change
    add_column :reports, :date, :datetime
  end
end
