# frozen_string_literal: true

class RecipeRequestsController < ApplicationController
  # GET /recipe_requests/new
  def new
    @recipe_request = Recipe.new
  end

  # POST /recipe_requests
  def create
    @recipe_request = Recipe.new(recipe_request_params)

    if @recipe_request.save
      redirect_to @recipe_request, notice: 'Recipe request was successfully created.'
    else
      render :new
    end
  end

  private

  # Only allow a trusted parameter "white list" through.
  def recipe_request_params
    params.require(:recipe_request).permit(:new)
  end
end
