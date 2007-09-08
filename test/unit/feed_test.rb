require File.dirname(__FILE__) + '/../test_helper'

class FeedTest < Test::Unit::TestCase
  
  def test_should_initialize_with_new_brigade
    brigade = Brigade.new
    assert brigade.rss_feed.is_a?(RSS)
    assert brigade.calendar.is_a?(ICS)
  end
  
  def test_should_create_with_newly_created_brigade
    assert_difference "Feed.count", 2 do
      Brigade.create :city => "Tampa", :name => "Tampa.rb"
    end
  end
  
  def test_should_update_with_updated_brigade
    brigade = Brigade.create :city => "Tampa",
                             :name => "Tampa.rb",
                             :feeds => {
                               :rss => { :uri => ""  },
                               :ics => { :uri => "http://ruby.meetup.com/73/calendar/ical/The+Tampa+Ruby+Brigade/"  }
                             }
    assert_equal "", brigade.rss_feed.uri
    assert_equal "http://ruby.meetup.com/73/calendar/ical/The+Tampa+Ruby+Brigade/", brigade.calendar.uri
    brigade.update_attributes :feeds => {
                                :rss => { :uri => "http://tamparuby.com/blog.xml"  },
                                :ics => { :uri => "http://tamparuby.com/events.ics"  }
                              }
    assert_equal "http://tamparuby.com/blog.xml", brigade.rss_feed.uri
    assert_equal "http://tamparuby.com/events.ics", brigade.calendar.uri
  end
  
end
