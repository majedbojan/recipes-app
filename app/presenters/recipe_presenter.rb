# frozen_string_literal: true

module RecipePresenter
  extend ActiveSupport::Concern

  included do
    acts_as_api

    api_accessible :base do |t|
      t.add :id
      t.add :name
      t.add :image_url
      t.add :author_name
      t.add :rate_percentage
    end

    ## ----------------------- Consumer Response ---------------------- ##

    api_accessible :index, extend: :base

    api_accessible :show, extend: :base do |t|
      t.add :budget
      t.add :cook_time
      t.add :difficulty
      t.add :budget_fr
      t.add :author_name
      t.add :difficulty_fr
      t.add :people_quantity
      t.add :tags, template: :show
      t.add :ingredients, template: :show
      t.add :feedbacks
    end

    ## ----------------------- Admin Response ------------------------- ##
  end
end
