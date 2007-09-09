class RSS < Feed
  has_many :headlines, :foreign_key => "feed_id", :dependent => :destroy
  
  def fetch
    response = super
    response.code == "200" ? response.body : "<?xml version=\"1.0\"?><rss version=\"2.0\"><channel></channel></rss>"
  end
  
  def sync
    self.title = parse.title
    super
  end
  
  def parse
    # Cache it while the object is alive in memory
    @parsed ||= SimpleRSS.parse(fetch) 
  end
  
  # Create Headline objects from feed items
  def transmogrify
    returning Array.new do |headlines|
      parse.items.each do |item|
        headlines << Headline.new(
          :summary      => item[:title],
          :description  => item[:description] || item[:content],
          :guid         => item[:guid]        || item[:id],
          :published_at => item[:pubDate]     || item[:published],
          :uri          => item[:link]
        )
      end
    end
  end
  
end
