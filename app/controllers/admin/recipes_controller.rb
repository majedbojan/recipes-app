# frozen_string_literal: true

module Admin
  class RecipesController < Admin::BaseController
    before_action :set_recipe, only: %i[show edit update destroy]

    # GET /recipes
    def index
      @q = Recipe.includes(:user).ransack(params[:q])
      @q.sorts = 'created_at desc' if @q.sorts.empty?
      @pagy, @recipes = pagy(@q.result(distinct: true))
    end

    # GET /recipes/1
    def show; end

    # GET /recipes/new
    def new
      @recipe = Recipe.new
    end

    # GET /recipes/1/edit
    def edit; end

    # POST /recipes
    def create
      @recipe = Recipe.new(params_processed)
      if @recipe.save
        redirect_to admin_recipe_path(@recipe), notice: 'Recipe was successfully created.'
      else
        render :new
      end
    end

    # PATCH/PUT /recipes/1
    def update
      if @recipe.update(params_processed)
        redirect_to admin_recipe_path(@recipe), notice: 'Recipe was successfully updated.'
      else
        render :edit
      end
    end

    # DELETE /recipes/1
    def destroy
      @recipe.destroy
      redirect_to admin_recipes_url, notice: 'Recipe was successfully destroyed.'
    end

    private

    def set_recipe
      @recipe = Recipe.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def recipe_params
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

    def params_processed
      recipe_params.merge(user: current_user)
    end
  end
end
