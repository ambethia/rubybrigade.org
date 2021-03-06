ActionController::Routing::Routes.draw do |map|
  map.resources :brigades, :collection => { :search => :get }, :member => { :destroy => [:get, :delete] }
  map.brigade_destroy '/brigades/:id/destroy', :controller => 'brigades', :action => 'destroy'

  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  # map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  # map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  # map.resources :products

  # Sample resource route with options:
  # map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  # map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  map.root :controller => "brigades", :conditions => { :domain => "" }
  
  map.feed "feeds/:action", :controller => "feeds", :format => "rss"
  
  map.exceptions '/logged_exceptions/:action/:id', :controller => 'logged_exceptions', :action => 'index', :id => nil 
end
