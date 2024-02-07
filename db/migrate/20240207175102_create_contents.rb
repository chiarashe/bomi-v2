class CreateContents < ActiveRecord::Migration[7.1]
  def change
    create_table :contents do |t|
      t.string :title
      t.string :text
      t.string :link_video
      t.string :content_type
      t.string :theme_type
      t.references :doctor, null: false, foreign_key: true

      t.timestamps
    end
  end
end
