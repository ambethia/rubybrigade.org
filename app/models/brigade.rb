class Brigade < ActiveRecord::Base
  def location
    "#{city} #{state_region} #{country}"
  end
end
