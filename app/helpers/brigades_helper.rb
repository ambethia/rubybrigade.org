module BrigadesHelper
  def points_for_mapping(brigades)
    brigades.map{ |b| {
      'id'          => b.id,
      'name'        => b.name,
      'description' => b.description,
      'lat'         => b.lat,
      'lng'         => b.lng
    } }.to_json
  end
end
