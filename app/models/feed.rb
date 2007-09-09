class Feed < ActiveRecord::Base
  belongs_to :brigade
  has_many   :feed_items
  
  USER_AGENT = "rubybrigade.org/0.1"
  
  attr_accessor :parsed
  
  def sync
    self.feed_items = transmogrify
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
      uri  = URI.parse(self["uri"])
      http = Net::HTTP.new(uri.host,uri.port)
      http.get(uri.path, 'User-Agent' => USER_AGENT)
    end
  
end
