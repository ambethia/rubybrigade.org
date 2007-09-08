class DropUrlColumnsFromBrigades < ActiveRecord::Migration
  def self.up
    remove_column :brigades, :rss_url
    remove_column :brigades, :ical_url
  end

  def self.down
    add_column :brigades, :rss_url,  :string
    add_column :brigades, :ical_url, :string
  end
end
