ENV["RAILS_ENV"] = "test"
require File.expand_path(File.dirname(__FILE__) + "/../config/environment")
require 'test_help'

require File.join(File.dirname(__FILE__), '/../vendor/plugins/geokit/test/base_geocoder_test')
GeoKit::Geocoders::google = 'Google'

class Test::Unit::TestCase
  # Transactional fixtures accelerate your tests by wrapping each test method
  # in a transaction that's rolled back on completion.  This ensures that the
  # test database remains unchanged so your fixtures don't have to be reloaded
  # between every test method.  Fewer database queries means faster tests.
  #
  # Read Mike Clark's excellent walkthrough at
  #   http://clarkware.com/cgi/blosxom/2005/10/24#Rails10FastTesting
  #
  # Every Active Record database supports transactions except MyISAM tables
  # in MySQL.  Turn off transactional fixtures in this case; however, if you
  # don't care one way or the other, switching from MyISAM to InnoDB tables
  # is recommended.
  self.use_transactional_fixtures = true

  # Instantiated fixtures are slow, but give you @david where otherwise you
  # would need people(:david).  If you don't want to migrate your existing
  # test cases which use the @david style and don't mind the speed hit (each
  # instantiated fixtures translates to a database query per test method),
  # then set this back to true.
  self.use_instantiated_fixtures  = false

  # Setup all fixtures in test/fixtures/*.(yml|csv) for all tests in alphabetical order.
  # If you need to control the loading order (due to foreign key constraints etc), you'll
  # need to change this line to explicitly name the order you desire.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherent this setting
  fixtures :all

  GOOGLE_CITY=<<-EOF.strip
  <?xml version="1.0" encoding="UTF-8"?><kml xmlns="http://earth.google.com/kml/2.0"><Response><name>Tampa</name><Status><code>200</code><request>geocode</request></Status><Placemark id="p1"><address>Tampa, FL, USA</address><AddressDetails Accuracy="4" xmlns="urn:oasis:names:tc:ciq:xsdschema:xAL:2.0"><Country><CountryNameCode>US</CountryNameCode><AdministrativeArea><AdministrativeAreaName>FL</AdministrativeAreaName><SubAdministrativeArea><SubAdministrativeAreaName>Hillsborough</SubAdministrativeAreaName><Locality><LocalityName>Tampa</LocalityName></Locality></SubAdministrativeArea></AdministrativeArea></Country></AddressDetails><Point><coordinates>-82.459290,27.946500,0</coordinates></Point></Placemark></Response></kml>
  EOF
  
  def mock_geocode_success(location)
    response = MockSuccess.new
    response.expects(:body).returns(GOOGLE_CITY)
    url = "http://maps.google.com/maps/geo?q=#{CGI.escape(location)}&output=xml&key=Google&oe=utf-8"
    GeoKit::Geocoders::GoogleGeocoder.expects(:call_geocoder_service).with(url).returns(response)
  end
  
  def mock_geocode_failure(location)
    response = MockFailure.new
    url = "http://maps.google.com/maps/geo?q=#{CGI.escape(location)}&output=xml&key=Google&oe=utf-8"
    GeoKit::Geocoders::GoogleGeocoder.expects(:call_geocoder_service).with(url).returns(response)
  end

end