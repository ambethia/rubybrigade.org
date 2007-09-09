require File.dirname(__FILE__) + '/../test_helper'
require File.dirname(__FILE__) + '/../mocks/test/http'

class FeedItemTest < Test::Unit::TestCase
  
  def setup
    # Because we're loading files in the test, not a real HTTP response
    File.any_instance.stubs(:code).returns("200")
    @brigade = Brigade.create(
      :name => "Tampa.rb",
      :city => "Tampa",
      :feeds => {
        :rss => { :uri => "rss.xml" },
        :ics => { :uri => "cal.ics" }
      }
    )
  end
  
  def test_should_be_created_when_syncing_rss_feed
    assert_difference("FeedItem.count", 2) { @brigade.rss_feed.sync }
  end

  def test_should_be_created_when_syncing_calendar
    assert_difference("FeedItem.count") { @brigade.calendar.sync }
  end
  
end
