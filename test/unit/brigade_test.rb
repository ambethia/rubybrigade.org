require File.dirname(__FILE__) + '/../test_helper'

class BrigadeTest < Test::Unit::TestCase
  fixtures :brigades

  def test_should_generate_location_string_from_city_state_and_country
    brigade = Brigade.new :city => "Tampa", :state_region => "FL", :country => "USA"
    assert_equal "Tampa FL USA", brigade.location
  end
end
