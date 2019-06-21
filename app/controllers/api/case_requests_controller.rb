class Api::CaseRequestsController < ApplicationController
  before_action :authenticate!
  rescue_from CaseRequest::InvalidPeriod, with: :missing_parameters

  def index
    @case_requests = CaseRequest.get_count_by_period(params[:period])
  end

  def create
    @case_request = CaseRequest.new(case_request_params)
    if @case_request.save
      render :show
    else
      render_errors(@case_request)
    end
  end

  private

  def case_request_params
    params.fetch(:case_request, {}).permit(CaseRequest.attribute_names - [:id, :created_at, :updated_at])
  end
end
