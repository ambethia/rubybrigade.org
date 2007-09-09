require File.dirname(__FILE__) + '/../test_helper'

class FeedTest < Test::Unit::TestCase
  
  def test_should_initialize_with_new_brigade
    brigade = Brigade.new
    assert brigade.rss_feed.is_a?(RSS)
    assert brigade.calendar.is_a?(ICS)
  end
  
  def test_should_create_with_newly_created_brigade
    mock_geocode_success 'Tampa'

    assert_difference "Feed.count", 2 do
      Brigade.create :city => "Tampa", :name => "Tampa.rb"
    end
  end
  
  def test_should_update_with_updated_brigade
    mock_geocode_success 'Tampa'

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
  
  def test_should_raise_an_error_when_calling_parse_on_feed_parent_class
    assert_raise RuntimeError do
      Feed.new.send 'parse'
    end
  end
  
  def test_should_raise_an_error_when_calling_transmogrify_on_feed_parent_class
    assert_raise RuntimeError do
      Feed.new.send 'transmogrify'
    end
  end
  
  def test_should_return_empty_string_when_calling_fetch_on_ics
    assert_equal "", ICS.new.send('fetch')
  end
  
  def test_should_return_empty_rss_xml_packet_when_calling_fetch_on_rss
    assert_equal "<?xml version=\"1.0\"?><rss version=\"2.0\"><channel><title></title></channel></rss>", RSS.new.send('fetch')
  end
  
  
end
