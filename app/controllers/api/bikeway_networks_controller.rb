class Api::BikewayNetworksController < ApplicationController
  def nearest_network
    query ="query 
        { 
          nearest_bikeway_network(lat: #{params[:lat]}, long: #{params[:long]}, max_distance: #{params[:max_distance]}) {
            id,
            install_mo,
            install_yr,
            streetname,
            symbology, 
            dist
          }
        }"
    result = LanebreachApiSchema.execute(query)
    render json: result["data"]["nearest_bikeway_network"][0]
  end

  def show
    @bikeway_network = BikewayNetwork.find(params[:id])
  end
end