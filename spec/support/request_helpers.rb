# frozen_string_literal: true

module RequestHelpers
  def json_response
    JSON.parse(response.body, symbolize_names: true).with_indifferent_access
  end

  def data_response
    json_response[:data]
  end

  def error_response
    json_response[:error]
  end

  def success_response
    json_response[:success]
  end

  def message_response
    json_response[:message]
  end

  def status_response
    json_response[:status]
  end

  def generate_token(user)
    JWT.encode(user.login_payload, Rails.application.credentials.secret_key_base, 'HS256')
  end

  def request_headers(user)
    { 'Authorization' => generate_token(user) }
  end
end
