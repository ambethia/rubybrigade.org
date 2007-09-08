class AddGuidToFeedItems < ActiveRecord::Migration
  def self.up
    add_column :feed_items, :guid, :string
  end

  def self.down
    remove_column :feed_items, :guid
  end
end
