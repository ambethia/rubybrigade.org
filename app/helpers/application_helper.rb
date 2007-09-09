# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def home_url
    url = "http://rubybrigade.org"
    url += ":#{request.port}" unless request.port == 80
  end
end
