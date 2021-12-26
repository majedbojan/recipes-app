# frozen_string_literal: true

module Api
  module V1
    class IngredientsController < Api::V1::BaseController
      ## ------------------------------------------------------------ ##

      # GET : api/v1/ingredients/
      # Inherited from Api::V1::BaseController
      # def index; end

      ## ------------------------------------------------------------ ##

      private

      # Search filters
      def search_params
        {
          id:        params[:id],
          recipe_id: params[:recipe_id],

          name_cont: params[:search]
        }
      end
    end
  end
end
