# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  include ExceptionLoggable

  helper :all # include all helpers, all the time
  
  def disallow_subdomain
    if request.domain == "rubybrigade.org" && request.subdomains.length > 0
      redirect_to "http://" + "rubybrigade.org#{request.port != 80 ? ":#{request.port}" : ""}" + request.request_uri 
    end
  end
  
end
