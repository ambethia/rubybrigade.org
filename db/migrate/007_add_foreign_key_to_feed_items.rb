class AddForeignKeyToFeedItems < ActiveRecord::Migration
  def self.up
    add_column :feed_items, :feed_id, :integer, :null => false
    add_index  :feed_items, :feed_id
  end

  def self.down
    remove_column :feed_items, :feed_id
    remove_index  :feed_items, :feed_id
  end
end
