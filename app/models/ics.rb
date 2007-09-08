class ICS < Feed
  has_many :events, :foreign_key => "feed_id", :dependent => :destroy
  
  def parse
    @parsed ||= Vpim::Icalendar.decode(self.fetch)
  end
  
  # Create Event objects from iCal items
  def transmogrify
    returning Array.new do |events|
      parse.map(&its.components(Vpim::Icalendar::Vevent)).flatten.each do |event|
        events << Event.new(
          :summary      => event.summary,
          :description  => event.description,
          :uri          => event.url,
          :location     => event.location,
          :starts_at    => event.dtstart,
          :ends_at      => event.dtend
        )
      end
    end
  end
  
end
