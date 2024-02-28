class AddTokenToPatients < ActiveRecord::Migration[7.1]
  def change
    add_column :patients, :token, :string
    add_index :patients, :token, unique: true
  end
end
