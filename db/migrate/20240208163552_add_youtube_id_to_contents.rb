class AddYoutubeIdToContents < ActiveRecord::Migration[7.1]
  def change
    add_column :contents, :youtube_id, :string
  end
end
