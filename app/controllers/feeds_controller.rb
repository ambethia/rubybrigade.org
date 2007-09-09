class FeedsController < ApplicationController
  layout false
  
  def events
    @events = Event.upcoming(12)
  end
  
  def brigades
    @brigades = Brigade.newest(12)
  end
  
end
