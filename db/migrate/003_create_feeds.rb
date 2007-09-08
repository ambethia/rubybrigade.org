class CreateFeeds < ActiveRecord::Migration
  def self.up
    create_table :feeds do |t|
      t.string    :uri
      t.datetime  :last_checked_at
      t.integer   :brigade_id
      t.string    :type

      t.timestamps 
    end
  end

  def self.down
    drop_table :feeds
  end
end
