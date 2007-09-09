class Event < FeedItem
  
  def self.upcoming(limit = 5)
    find :all, :conditions => ["starts_at >= ?", Time.now],
               :order      => "starts_at ASC",
               :limit      => limit
  end
  
end
