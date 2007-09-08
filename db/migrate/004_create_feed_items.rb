class CreateFeedItems < ActiveRecord::Migration
  def self.up
    create_table :feed_items do |t|
      t.string    :summary
      t.text      :description
      t.string    :uri
      t.text      :location
      t.datetime  :starts_at
      t.datetime  :ends_at
      t.string    :type

      t.timestamps 
    end
  end

  def self.down
    drop_table :feed_items
  end
end
