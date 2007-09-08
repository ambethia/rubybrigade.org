class Feed < ActiveRecord::Base
  belongs_to :brigade
  
  USER_AGENT = "rubybrigade.org/0.1"
  
  def sync
    self.class.transaction do
      
    end
  end
  
  protected
  
    # Fetch the content of the feeds URI
    def fetch
      uri  = URI.parse(self["uri"])
      http = Net::HTTP.new(uri.host,uri.port)
      http.get(uri.path, 'User-Agent' => USER_AGENT).body
    end
  
end
