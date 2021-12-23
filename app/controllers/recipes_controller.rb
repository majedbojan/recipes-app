# frozen_string_literal: true

class RecipesController < ApplicationController
  before_action :set_recipe, only: %i[show]

  # GET /recipes
  def index
    @q = Recipe.active
               .ransack(params[:q])
    @pagy, @recipes = pagy(@q.result(distinct: true))
  end

  # GET /recipes/1
  def show; end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_recipe
    @recipe = Recipe.find(params[:id])
  end

  def recipe_params
    params.require(:recipe)
          .permit(
            :name,
            :email
          )
  end
end
