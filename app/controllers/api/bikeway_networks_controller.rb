# frozen_string_literal: true

class Api::BikewayNetworksController < ApplicationController
  def nearest_network
    return render json: { error: "Sorry, missing 'lat' parameter." }, status: :unprocessable_entity if params[:lat].blank?
    return render json: { error: "Sorry, missing 'long' parameter." }, status: :unprocessable_entity if params[:long].blank?

    query = "query
        {
          nearest_bikeway_network(lat: #{params[:lat]}, long: #{params[:long]}, max_distance: #{params[:max_distance]}) {
            barrier,
            biap,
            buffered,
            cnn,
            contraflow,
            created_us,
            dir,
            direct,
            dist,
            double,
            facility_t,
            from_st,
            fy,
            geom,
            globalid,
            greenwave,
            id
            install_mo,
            install_yr,
            last_edite,
            length,
            notes,
            number,
            objectid,
            qtr,
            raised,
            shape_len,
            sharrow,
            sm_sweeper,
            street,
            streetname,
            surface_tr,
            symbology,
            time_creat,
            time_last_,
            to_st,
            update_mo,
            update_yr,
            date_creat,
            date_last_
          }
        }"
    result = LanebreachApiSchema.execute(query)
    render json: result['data']['nearest_bikeway_network'][0]
  end

  def show
    @bikeway_network = BikewayNetwork.find(params[:id])
  end
end
