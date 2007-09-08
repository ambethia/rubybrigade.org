class Brigade < ActiveRecord::Base
  acts_as_mappable :auto_geocode => {:field => :location, :error_message => 'could not be geocoded with information you provided.'}

  def location
    "#{city} #{state_region} #{country}"
  end
  
  # used by 'acts_as_mappable' for geocoding
  def address
    "#{city} #{state_region} #{postal_code} #{country}"
  end
end
