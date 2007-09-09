class Feed < ActiveRecord::Base
  belongs_to :brigade
  has_many   :feed_items
  
  after_save :sync
  
  USER_AGENT = "rubybrigade.org/0.1"
  
  attr_accessor :parsed
  
  def sync
    self.feed_items = transmogrify
    last_checked_at = Time.now
    update_without_callbacks
  end
  
  protected
    
    def parse
      raise "This method must be explicitly overridden in the #{self.class} class."
    end
    
    def transmogrify
      raise "This method must be explicitly overridden in the #{self.class} class."
    end
    
    # Fetch the content of the feeds URI
    def fetch
      unless self["uri"].blank?
        uri = URI.parse(self["uri"])
        http = Net::HTTP.new uri.host, uri.port
        response = http.get uri.path, 'User-Agent' => USER_AGENT
        response.code == "200" ? response.body : ""
      else ""
      end
    end
  
end
