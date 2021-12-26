# frozen_string_literal: true

module Api
  module V1
    class FeedbacksController < Api::V1::BaseController
      before_action :authenticate_user!, only: :create

      ## ------------------------------------------------------------ ##

      # GET : api/v1/recipes/:recipe_id/feedbacks
      # Inherited from Api::V1::BaseController
      # def index; end

      ## ------------------------------------------------------------ ##

      # POST : api/v1/recipes/:recipe_id/feedbacks
      # Inherited from Api::V1::BaseController
      # def create; end

      private

      # Search filters
      def search_params
        { recipe_id: params[:recipe_id] }
      end

      def feedback_params
        params.require(:feedback).permit(:comment, :rating)
      end

      def params_processed
        resource_params.merge(recipe: recipe, user: User.first)
      end

      def recipe
        Recipe.find(params[:recipe_id])
      end
    end
  end
end
