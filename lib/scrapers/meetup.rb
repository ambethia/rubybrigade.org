require File.expand_path(File.dirname(__FILE__) + "/../../config/environment")
require 'rubygems'
require 'hpricot'
require 'open-uri'

brigades = []
meetups  = Hpricot(open("http://ruby.meetup.com/about/"))/"#groups li.vcard"

meetups.each do |meetup|
  meetup_uri  = meetup.at("a.url")["href"].split("?").first
  brigades << {
    :name             => meetup.at(".fn").inner_text,
    :membership_size  => meetup.at(".note").inner_text.scan(/(\d*) members/).flatten.pop.to_i,
    :website_url      => meetup_uri,
    :lat              => meetup.at(".latitude").inner_text.to_f,
    :lng              => meetup.at(".longitude").inner_text.to_f,
    :city             => meetup.at(".locality").inner_text,
    :state_region     => meetup.at(".region") ? meetup.at(".region").inner_text : nil,
    :country          => meetup.at(".country-name").inner_text,
    :feeds            => { :ics => { :uri => "#{meetup_uri}/calendar/ical/" } }
  }
end

brigades.each do |brigade|
  meetup = Hpricot open(brigade[:website_url])
  brigade[:description]    = meetup.at(".groupDesc p") ? meetup.at(".groupDesc p").inner_text : nil
  brigade[:established_on] = Date.parse(meetup.at("#groupFounded").inner_text.chomp)
end

puts brigades.to_yaml