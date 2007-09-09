xml.instruct! :xml, :version=>"1.0" 
xml.rss(:version=>"2.0"){
  xml.channel{
    xml.title("Ruby Brigade")
    xml.link("http://rubybrigade.org/feeds/brigades")
    xml.description("New brigades from around the globe.")
    xml.language('en-us')
      for brigade in @brigades
        xml.item do
          xml.title(brigade.name)
          xml.description(simple_format(brigade.description))
          xml.pubDate(brigade.created_at.strftime("%a, %d %b %Y %H:%M:%S %z"))
          xml.link(brigade.website_url)
          xml.guid(Digest::MD5.hexdigest(brigade.id.to_s))
        end
      end
  }
}