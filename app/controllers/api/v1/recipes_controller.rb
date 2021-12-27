# frozen_string_literal: true

module Api
  module V1
    class RecipesController < Api::V1::BaseController
      before_action :authenticate_user!, only: :create

      ## ------------------------------------------------------------ ##

      # GET : api/v1/recipes/
      # Inherited from Api::V1::BaseController
      # def index; end

      ## ------------------------------------------------------------ ##

      # GET : api/v1/recipes/:id
      # Inherited from Api::V1::BaseController
      # def show; end
      ## ------------------------------------------------------------ ##

      # POST : api/v1/recipes/
      # Inherited from Api::V1::BaseController
      # def create; end

      ## ------------------------------------------------------------ ##

      private

      def recipe_params
        params.require(:recipe)
              .permit(
                :name,
                :budget,
                :cook_time,
                :image_url,
                :prep_time,
                :difficulty,
                :people_quantity,
                tags_attributes:        %i[id name _destroy],
                ingredients_attributes: %i[id name _destroy]
              )
      end

      # Search filters
      def search_params
        {
          name_cont:         params[:search],
          tags_id_in:        params[:tag_ids],
          ingredients_id_in: params[:ingredient_ids]
        }
      end

      def collection
        @collection ||= build_collection.includes(:user)
      end

      def params_processed
        resource_params.merge(status: 'pending')
      end
      # Custom ordering and sorting
      # def get_order; end
    end
  end
end