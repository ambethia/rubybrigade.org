class Brigade < ActiveRecord::Base
  acts_as_mappable :auto_geocode => {:field => :location, :error_message => 'could not be geocoded with information you provided.'}

  has_one :rss_feed, :class_name => "RSS"
  has_one :calendar, :class_name => "ICS"
  
  has_many :headlines, :through => :rss_feed
  has_many :events,    :through => :calendar

  attr_writer      :feeds
  after_create     :create_feeds
  after_save       :update_feeds

  def create_feeds
    create_rss_feed(@feeds[:rss])
    create_calendar(@feeds[:ics])
  end
  
  def update_feeds
    rss_feed.update_attributes @feeds[:rss] unless rss_feed.nil?
    calendar.update_attributes @feeds[:ics] unless calendar.nil?
  end
  
  def after_initialize
    @feeds ||= {}
    if new_record?
      build_rss_feed(@feeds[:rss]) if rss_feed.nil?
      build_calendar(@feeds[:ics]) if calendar.nil?
    end
  end

  def location
    "#{city} #{state_region} #{country}"
  end
  
  # used by 'acts_as_mappable' for geocoding
  def address
    "#{city} #{state_region} #{postal_code} #{country}"
  end
end
