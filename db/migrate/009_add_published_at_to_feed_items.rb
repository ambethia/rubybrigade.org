class AddPublishedAtToFeedItems < ActiveRecord::Migration
  def self.up
    add_column :feed_items, :published_at, :datetime
  end

  def self.down
    remove_column :feed_items, :published_at
  end
end
