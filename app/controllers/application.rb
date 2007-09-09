# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  include ExceptionLoggable

  helper :all # include all helpers, all the time
  
  def subdomain_present?
    request.subdomains.length > 0
  end
  
  def disallow_subdomain
    if request.domain == "rubybrigade.org" && subdomain_present?
      url  = "http://rubybrigade.org"
      url += ":#{request.port}" unless request.port == 80 # include the port unless it's 80, so it works in development mode :)
      url += request.request_uri

      redirect_to url
    end
  end
  
  def ensure_domain
    unless %w(rubybrigade.org localhost test.host).include?(request.domain)
      url  = "http://rubybrigade.org"
      url += ":#{request.port}" unless request.port == 80 # include the port unless it's 80, so it works in development mode :)
      url += request.request_uri

      redirect_to url
    end
  end
  
end
