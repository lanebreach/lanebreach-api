class Api::BikewayNetworksController < ApplicationController
  def nearest_network
    return render json: { error: "Sorry, missing 'lat' parameter." }, status: :unprocessable_entity if params[:lat].blank?
    return render json: { error: "Sorry, missing 'long' parameter." }, status: :unprocessable_entity if params[:long].blank?

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