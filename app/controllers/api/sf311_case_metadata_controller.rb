class Api::Sf311CaseMetadataController < ApplicationController
  def index
    render json: {'Status': "Okay!"}, status: :ok
  end
end
