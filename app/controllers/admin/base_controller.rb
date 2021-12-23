# frozen_string_literal: true

module Admin
  class BaseController < ApplicationController
    layout 'admin'

    before_action :authenticate_user!
    before_action :reject_non_admin_users!

    private

    def reject_non_admin_users!
      return if current_user.admin?

      redirect_to root_url, alert: 'You are not authorized to access this page'
    end
  end
end
