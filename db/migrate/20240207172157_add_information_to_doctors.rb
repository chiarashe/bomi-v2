class AddInformationToDoctors < ActiveRecord::Migration[7.1]
  def change
    add_column :doctors, :first_name, :string
    add_column :doctors, :last_name, :string
    add_column :doctors, :date_birth, :date
    add_column :doctors, :location, :string
    add_column :doctors, :phone_number, :string
    add_column :doctors, :profession, :string
    add_column :doctors, :cedula_profesional, :string
    add_column :doctors, :curp, :string
    add_column :doctors, :studies, :string
  end
end
