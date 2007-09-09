module BrigadesHelper
  def points_for_mapping(brigades)
    brigades.map{ |b| {
      'id'          => b.id,
      'name'        => b.name,
      'url'         => brigade_url(b),
      'description' => b.description,
      'lat'         => b.lat,
      'lng'         => b.lng
    } }.to_json
  end
  
  def brigade_url(brigade)
    unless RAILS_ENV == 'development' || brigade.subdomain.blank?
      url  = "http://"
      url += brigade.subdomain
      url += ".rubybrigade.org"
      url += ":#{request.port}" unless request.port == 80 # include the port unless it's 80, so it works in development mode :)
      
      url
    else
      brigade_path(brigade)
    end
  end
end
