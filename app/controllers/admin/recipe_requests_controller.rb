# frozen_string_literal: true

module Admin
  class RecipeRequestsController < Admin::BaseController
    before_action :set_recipe, only: %i[show edit update]

    # GET /recipe_requests
    def index
      @q = Recipe.pending.includes(:user).ransack(params[:q])
      @q.sorts = 'created_at desc' if @q.sorts.empty?
      @pagy, @recipe_requests = pagy(@q.result(distinct: true))
    end

    # GET /recipe_requests/1
    def show; end

    # GET /recipes/1/edit
    def edit; end

    # PATCH/PUT /recipes/1
    def update
      if @recipe_request.update(recipe_params)
        redirect_to admin_recipe_path(@recipe), notice: 'Recipe was successfully updated.'
      else
        render :edit
      end
    end

    private

    def set_recipe
      @recipe_request = Recipe.find(params[:id])
    end

    def approve_params; end
  end
end
