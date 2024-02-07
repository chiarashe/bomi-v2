class AddInformationToPatients < ActiveRecord::Migration[7.1]
  def change
    add_column :patients, :first_name, :string
    add_column :patients, :last_name, :string
    add_column :patients, :date_birth, :date
    add_column :patients, :location, :string
    add_column :patients, :phone_number, :string
    add_column :patients, :link, :string
    add_column :patients, :goal, :string
  end
end
