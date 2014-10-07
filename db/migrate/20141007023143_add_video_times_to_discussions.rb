class AddVideoTimesToDiscussions < ActiveRecord::Migration
  def change
    add_column :discussions, :start_time, :string
    add_column :discussions, :end_time, :string
  end
end
