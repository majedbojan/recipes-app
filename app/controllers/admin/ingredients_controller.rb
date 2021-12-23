# frozen_string_literal: true

module Admin
  class IngredientsController < Admin::BaseController
    before_action :set_ingredient, only: %i[show edit update destroy]

    # GET /ingredients
    def index
      @q = Ingredient.ransack(params[:q])
      @q.sorts = 'created_at desc' if @q.sorts.empty?
      @pagy, @ingredients = pagy(@q.result(distinct: true))
    end

    # GET /ingredients/1
    def show; end

    # GET /ingredients/new
    def new
      @ingredient = Ingredient.new
    end

    # GET /ingredients/1/edit
    def edit; end

    # POST /ingredients
    def create
      @ingredient = Ingredient.new(ingredient_params)

      if @ingredient.save
        redirect_to admin_ingredient_path(@ingredient), notice: 'ingredient was successfully created.'
      else
        render :new
      end
    end

    # PATCH/PUT /ingredients/1
    def update
      if @ingredient.update(ingredient_params)
        redirect_to admin_ingredient_path(@ingredient), notice: 'Ingredient was successfully updated.'
      else
        render :edit
      end
    end

    # DELETE /ingredients/1
    def destroy
      @ingredient.destroy
      redirect_to admin_ingredients_url, notice: 'Ingredient was successfully destroyed.'
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_ingredient
      @ingredient = Ingredient.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def ingredient_params
      params.require(:ingredient).permit(:name)
    end
  end
end
