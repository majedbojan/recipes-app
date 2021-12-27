# frozen_string_literal: true

module Api
  module V1
    class SessionsController < Api::V1::BaseController
      skip_before_action :authenticate_user!, only: :create

      ## ------------------------------------------------------------ ##

      # POST - v1/login
      def create
        missing_params!(:email, :password)

        user = User.login(params[:email], params[:password])
        return render_unprocessable_entity(message: 'User account not found') if user.blank?
        return render_unprocessable_entity(message: 'User account is not active') if user.inactive?

        data = { user: user.as_api_response(:show), token: generate_token(user) }

        render_success(message: I18n.t('sessions.login_successfully'), data: data)
      end

      ## ------------------------------------------------------------ ##

      private

      def generate_token(user)
        payload = user.login_payload
        JsonWebToken.encode(payload)
      end

      def login_params
        params.permit(:email, :password)
      end
    end
  end
end
