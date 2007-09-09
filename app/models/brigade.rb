class Brigade < ActiveRecord::Base
  acts_as_mappable :auto_geocode => {:field => :location, :error_message => 'could not be geocoded with information you provided.'}

  has_one :rss_feed, :class_name => "RSS"
  has_one :calendar, :class_name => "ICS"
  
  has_many :headlines, :through => :rss_feed, :order => "feed_items.published_at DESC"
  has_many :events,    :through => :calendar, :order => "feed_items.starts_at ASC" do
    
    def upcoming(limit = 5)
      find :all, :conditions => ["starts_at >= ?", Time.now],
                 :order      => "starts_at ASC",
                 :limit      => limit
    end
    
  end

  attr_writer      :feeds
  after_create     :create_feeds
  after_save       :update_feeds
  
  validates_presence_of :name

  class << self
    
    def newest(limit = 5)
      find :all, :order => "created_at DESC", :limit => limit
    end
    
  end

  def create_feeds
    create_rss_feed @feeds[:rss].symbolize_keys
    create_calendar @feeds[:ics].symbolize_keys
  end
  
  def update_feeds
    rss_feed.update_attributes @feeds[:rss].symbolize_keys unless rss_feed.nil?
    calendar.update_attributes @feeds[:ics].symbolize_keys unless calendar.nil?
  end
  
  def after_initialize
    # real parameters or a fakey hash.
    @feeds ||= { :rss => {}, :ics => {} }
    @feeds.symbolize_keys!
    if new_record?
      build_rss_feed(@feeds[:rss].symbolize_keys) if rss_feed.nil?
      build_calendar(@feeds[:ics].symbolize_keys) if calendar.nil?
    end
  end

  def location
    [city, state_region, country].compact.join(' ')
  end
end
