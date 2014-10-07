class AddVideoIdToDiscussions < ActiveRecord::Migration
  def change
    add_column :discussions, :video_id, :integer
  end
end
