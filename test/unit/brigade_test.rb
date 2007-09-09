require File.dirname(__FILE__) + '/../test_helper'

class BrigadeTest < Test::Unit::TestCase

  def test_should_generate_location_string_from_city_state_and_country
    brigade = Brigade.new :city => "Tampa", :state_region => "FL", :country => "USA"
    assert_equal "Tampa FL USA", brigade.location
  end

  def test_should_retrieve_a_brigades_upcoming_events
    brigade = Brigade.new :name => "Tampa.rb", :city => "Tampa", :state_region => "FL", :postal_code => "33604", :country => "USA"
    mock_geocode_success brigade.location

    brigade.save
    brigade.calendar.create
    
    brigade.calendar.events.create :starts_at => 1.day.since
    brigade.calendar.events.create :starts_at => 2.days.since
    
    assert_equal 2, brigade.events.upcoming.length
  end
end
