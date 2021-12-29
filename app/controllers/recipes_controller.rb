# frozen_string_literal: true

class RecipesController < ApplicationController
  before_action :set_recipe, only: %i[show]
  before_action :apply_filters, only: :index

  # GET /recipes
  def index
    @q = Recipe.includes(:user).active
               .ransack(params[:q])
    @pagy, @recipes = pagy(@q.result(distinct: true))
  end

  # GET /recipes/1
  def show; end

  # GET /recipes/search
  def search
    @recipes = \
      Recipe
      .ransack(name_or_tags_name_or_ingredients_name_cont: params[:q])
      .result
      .distinct

    render 'search', layout: false
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_recipe
    @recipe = Recipe.find(params[:id])
  end

  # def recipe_params
  #   params.require(:recipe).permit( :name, :email)
  # end

  def apply_filters
    search_params = params[:q] || {}

    @q = \
      Recipe
      .includes(:user)
      .active
      .ransack(
        name_in:       search_params.slice('name_cont', 'tags_name_cont', 'ingredients_name_cont').values,
        difficulty_eq: search_params['difficulty_eq'],
        budget_eq:     search_params['budget_eq']
      )
  end
end
