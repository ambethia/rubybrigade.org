class RSS < Feed
  has_many :headlines, :foreign_key => "feed_id", :dependent => :destroy
    
  def sync
    self.title = parse.title
    super
  end
  
  protected
  
    def fetch
      body = super
      body.blank? ? "<?xml version=\"1.0\"?><rss version=\"2.0\"><channel><title></title></channel></rss>" : body
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
