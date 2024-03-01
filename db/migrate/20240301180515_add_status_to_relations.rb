class AddStatusToRelations < ActiveRecord::Migration[7.1]
  def change
    add_column :relations, :status, :string, default: "pending"
  end
end
