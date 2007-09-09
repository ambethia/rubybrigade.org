xml.instruct! :xml, :version=>"1.0" 
xml.rss(:version=>"2.0"){
  xml.channel{
    xml.title("Ruby Brigade")
    xml.link("http://rubybrigade.org/feeds/events")
    xml.description("Upcoming events from ruby user groups around the globe.")
    xml.language('en-us')
      for event in @events
        xml.item do
          xml.title(event.summary)
          xml.description(simple_format(event.description))
          xml.pubDate(event.starts_at.strftime("%a, %d %b %Y %H:%M:%S %z"))
          xml.link(event.uri)
          xml.guid(Digest::MD5.hexdigest(event.id.to_s))
        end
      end
  }
}