# frozen_string_literal: true

module Admin
  class UsersController < Admin::BaseController
    before_action :set_user, except: %i[index]

    # GET /admin/users
    def index
      @q = User.ransack(params[:q])
      @q.sorts = 'name asc' if @q.sorts.empty?
      @pagy, @users = pagy(@q.result(distinct: true))
    end

    # GET /admin/users/new
    def new
      @user = User.new
    end

    # GET /admin/users/1/edit
    def edit; end

    # PATCH/PUT /admin/users/1
    def update
      if @user.update(user_params)
        redirect_to admin_user_path(@user), notice: 'User was successfully updated.'
      else
        render :edit
      end
    end

    # DELETE /admin/users/1
    def destroy
      @user.destroy
      redirect_to admin_users_url, notice: 'User was successfully destroyed.'
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def user_params
      params.require(:user)
            .permit(:name, :email, :phone, :role, :status)
    end
  end
end
