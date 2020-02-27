class Api::Sf311CasesController < ApplicationController
  def index
    @lane_blockages =
      Sf311Case
        .left_outer_joins(:sf311_case_metadatum)
        .select('sf311_cases.*,sf311_case_metadata.*')

    if params[:start_time]
      @lane_blockages =
        @lane_blockages.where('requested_datetime >= ?', params[:start_time])
    end

    if params[:end_time]
      @lane_blockages =
        @lane_blockages.where('requested_datetime <= ?', params[:end_time])
    end

    unless params.has_key?(:skip_pagination)
      @lane_blockages =
        @lane_blockages.paginate(
          page: (params[:page] || 1),
          per_page: (params[:per_page] || 30)
        )
    end
  end

  def create
    require 'pry'; binding.pry
    @sf311_case = Sf311Case.new(sf311_case_params)

    if @sf311_case.save
      # TODO: Perform this request in the background (e.g., Resque, Sidekiq)
      # NOTE: This functionality is currently disabled in non-prod environments
      Sf311CaseService.create_case(sf311_case_params)

      render :show
    else
      render json: { error: 'Error creating new 311 case' },
             status: :unprocessable_entity
    end
  end

  private

  def sf311_case_params
    # TODO: Be more explicit about which attributes are supported
    params.
      fetch(:sf311_case, {}).
      permit(Sf311Case.attribute_names - [:id, :created_at, :updated_at])
  end
end
