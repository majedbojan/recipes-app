# frozen_string_literal: true

module Api
  module V1
    class ApiController < ActionController::API
      include ExceptionHandler
      include JsonResponders
      include MissingData
      include Pagy::Backend
      include ActionController::MimeResponds

      # Authenticate the request by headers (used for all apis)
      def authenticate_user!
        missing_headers!('Authorization')
        @token ||= AuthenticateUser.get(request.headers['Authorization'].split.last)
        set_curret_user
      end

      private

      attr_reader :current_user

      # Set Current User and Access type or reject the request if user is forbidden
      def set_curret_user
        @current_user = @token[:user]
        return render_forbidden(error: 1201, message: I18n.t('errors.1305')) if @current_user.inactive?
      end
    end
  end
end
