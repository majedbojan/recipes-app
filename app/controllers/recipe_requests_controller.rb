# frozen_string_literal: true

class RecipeRequestsController < ApplicationController
  # GET /recipe_requests/new
  def new
    @recipe = Recipe.new
  end

  # POST /recipe_requests
  def create
    @recipe = Recipe.new(recipe_request_params)

    if @recipe.save
      redirect_to @recipe, notice: 'Recipe request was successfully created.'
    else
      render :new
    end
  end

  private

  # Only allow a trusted parameter "white list" through.
  def recipe_request_params
    params.require(:recipe)
          .permit(
            :name,
            :budget,
            :status,
            :cook_time,
            :image_url,
            :prep_time,
            :difficulty,
            :people_quantity,
            tags_attributes:        %i[id name _destroy],
            ingredients_attributes: %i[id name _destroy]
          )
  end
end
