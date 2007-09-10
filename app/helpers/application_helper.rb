# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def home_url
    url = ROOT_URL
    url += ":#{request.port}" unless request.port == 80
  end
  
  def render_flash
    for name in [:notice, :warning, :message]
      html = content_tag('div', flash[name], :id => "flash_#{name}") if flash[name]
    end
    html
  end 
  
  def analytics
   if RAILS_ENV == "production"
    return <<-END
    <script src="http://www.google-analytics.com/urchin.js" type="text/javascript"></script>
    <script type="text/javascript">_uacct = "UA-2098861-4";urchinTracker();</script>
    END
    end
  end
  
end
