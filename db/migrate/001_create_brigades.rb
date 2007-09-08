class CreateBrigades < ActiveRecord::Migration
  def self.up
    create_table :brigades do |t|
      t.column :name,            :string
      t.column :description,     :text
      t.column :membership_size, :integer
      t.column :website_url,     :string
      t.column :rss_url,         :string
      t.column :ical_url,        :string
      t.column :established_on,  :date
      t.column :city,            :string
      t.column :state_region,    :string
      t.column :country,         :string
      t.column :postal_code,     :string
      t.column :lat,             :decimal, :precision => 15, :scale => 10
      t.column :lng,             :decimal, :precision => 15, :scale => 10
      t.column :created_at,      :datetime
      t.column :updated_at,      :datetime
    end
  end

  def self.down
    drop_table :brigades
  end
end
