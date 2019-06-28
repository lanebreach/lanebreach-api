class Api::CaseRequestsController < ApplicationController
  before_action :authenticate!

  def counts
    @case_requests = CaseRequest.get_count(params[:days_back])
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
