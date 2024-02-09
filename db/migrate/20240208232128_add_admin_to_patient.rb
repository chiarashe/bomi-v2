class AddAdminToPatient < ActiveRecord::Migration[7.1]
  def change
    add_column :patients, :admin, :boolean, null:false, default:false
  end
end
