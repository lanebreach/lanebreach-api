class Api::BikewayNetworksController < ApplicationController
  def nearest_network
    if params[:lat].nil? || params[:long].nil?
      render json: {'Error': "Must provide 'lat' and 'long' as query parameters."}, status: :unprocessable_entity
    else
      bikeway_network = BikewayNetwork.nearest(params[:lat], params[:long], params[:max_distance]).first

      if bikeway_network.nil?
        render json: nil, status: :ok
      else
        render json: bikeway_network.to_json, status: :ok
      end
    end
  end

  def show
    @bikeway_network = BikewayNetwork.find(params[:id])
  end
end
