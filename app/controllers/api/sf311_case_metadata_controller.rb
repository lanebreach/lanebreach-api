class Api::Sf311CaseMetadataController < ApplicationController
  def index
    render json: { status: "ok" }, status: :ok
  end
end
