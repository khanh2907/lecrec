class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.string :title
      t.text :description
      t.string :content_url
      t.integer :community_id
      t.integer :user_id

      t.timestamps
    end
  end
end
