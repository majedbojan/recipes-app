# frozen_string_literal: true

class ProfilesController < ApplicationController
  # GET /profiles/1
  def show; end

  # GET /profiles/1/edit
  def edit; end

  # PATCH/PUT /profiles/1
  def update
    if current_user.update(profile_params)
      redirect_to profile_path, notice: 'Profile was successfully updated.'
    else
      render :show
    end
  end

  private

  def profile_params
    params.require(:user)
          .permit(:name, :email, :phone)
  end
end
