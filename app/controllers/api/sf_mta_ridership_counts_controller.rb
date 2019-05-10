class Api::SfMtaRidershipCountsController < ApplicationController
  def index
    @ridership_counts = SfMtaRidershipCount

    order_by = params[:order_by]

    if order_by
      sort_order = params[:sort_order] || 'DESC'
      return render json: { error: 'Supported sort_order values are ASC and DESC' }, status: :bad_request unless sort_order&.upcase.in?(%w[ASC DESC])

      @ridership_counts = @ridership_counts.order("#{order_by} #{sort_order}")
    end

    @ridership_counts = @ridership_counts.where(counter_location: params[:counter_location]) if params[:counter_location]
    @ridership_counts = @ridership_counts.where(days: params[:days].upcase) if params[:days]
    @ridership_counts = @ridership_counts.where(hour_of_collection_time: params[:hour_of_collection_time]) if params[:hour_of_collection_time]
    @ridership_counts = @ridership_counts.where(month_of_collection_time: params[:month_of_collection_time].capitalize) if params[:month_of_collection_time]
    @ridership_counts = @ridership_counts.where(year_of_collection_time: params[:year_of_collection_time]) if params[:year_of_collection_time]
    @ridership_counts = @ridership_counts.where(total_bike_count: params[:total_bike_count]) if params[:total_bike_count]

    @ridership_counts = @ridership_counts.paginate(page: (params[:page] || 1), per_page: (params[:per_page] || 30))
  end
end
