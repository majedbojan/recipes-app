# frozen_string_literal: true

class AuthenticateUser
  attr_reader :token

  def initialize(token = {})
    @token = token
  end

  def self.get(token = {})
    new(token).call
  end

  def call
    { user: user }
  end

  private

  def user
    @user ||= User.find(decoded_auth_token[:id]) if decoded_auth_token
  rescue ActiveRecord::RecordNotFound
    raise(CustomException::AuthUserNotFound, 'Authorizated user not exist')
  end

  def decoded_auth_token
    @decoded_auth_token ||= JsonWebToken.decode(auth_token)
  end

  def auth_token
    return token if token.present?

    raise(CustomException::MissingToken, 'token is missing')
  end
end
