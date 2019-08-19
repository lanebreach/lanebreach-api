class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Basic::ControllerMethods
  include ActionController::HttpAuthentication::Token::ControllerMethods

  rescue_from ActiveRecord::RecordNotUnique, with: :record_not_unique
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response
  rescue_from ActionController::ParameterMissing, with: :missing_parameters

  def render_unprocessable_entity_response(exception)
    render json: { error: exception.record.errors.full_messages.map { |error| error + "." }}, status: :unprocessable_entity
  end

  def render_not_found_response
    render json: { error: 'Sorry, resource not found.' }, status: :not_found
  end

  def record_not_unique
    render json: { error: 'Sorry, the record is not unique.' }, status: :unprocessable_entity
  end

  def missing_parameters
    render json: { error: 'Sorry, you are missing parameters.' }, status: :unprocessable_entity
  end

  def render_errors(record)
    render json: { error: record.errors.full_messages.to_sentence }, status: :unprocessable_entity
  end

  def authenticate!
    authenticate_or_request_with_http_token do |token, options|
      return true if token == ENV['AUTH_TOKEN']
    end
  end
end
