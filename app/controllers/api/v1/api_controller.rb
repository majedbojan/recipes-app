# frozen_string_literal: true

module Api
  module V1
    class ApiController < ActionController::API
      include ExceptionHandler
      include JsonResponders
      include Pagy::Backend
      include ActionController::MimeResponds

      # before_action :authenticate_user!
      # before_action :authenticate_by_params!, only: %i[export]
      # before_action :set_locale
      # require_power_check

      # self.responder = ApplicationResponder

      # Authenticate the request by headers (used for all apis)
      def authenticate_user!
        return if missing_headers!('Authorization')

        @token ||= AuthenticateUser.get(Employee, request.headers['Authorization'].split.last)
        set_curret_user_with_access
      end

      # # Authenticate the request by params
      # def authenticate_by_params!
      #   return if missing_params!('token')
      #   @token ||= AuthenticateUser.get(Employee, params[:token])
      #   set_curret_user_with_access
      # end

      private

      attr_reader :current_user

      # Set Power and inject it with current user
      # current_power do
      #   Power.new(@current_user)
      # end

      # Set request locale
      # def set_locale
      #   I18n.locale = params[:locale] || request.headers['locale'] || I18n.default_locale
      # end

      # Set Current User and Access type or reject the request if user is forbidden
      def set_curret_user_with_access
        @current_user = @token[:user]
        # @access       = @token[:access]
        # Current.user = @current_user
        # Use 1201 so mobile will automatically redirect diactivated users to login screen &&  # reject inactive/disabled users
        return render_forbidden(error: 1201, message: I18n.t('errors.1305')) unless @current_user.active?
      end

      # Const.role.keys.each do |r|
      #   define_method "#{r}?" do
      #     current_user.send("#{r}?")
      #   end
      # end
    end
  end
end
