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
  # module AuthHelpers
  # def auth_headers(user)
  #   api_token = ApiToken.create(user: user)
  #   {
  #     'Accept' => 'application/json',
  #     'Access-Token' => api_token.access_token,
  #     'Content_type' => 'application/json',
  #     'slug' => user.organization.slug
  #   }
  # end

  # def basic_auth_value(username, password)
  #   credentials = Base64.encode64("#{username}:#{password}")
  #   "Basic #{credentials}".gsub("\n", "")
  # end
  # end
end
