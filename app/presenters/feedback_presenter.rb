# frozen_string_literal: true

module FeedbackPresenter
  extend ActiveSupport::Concern

  included do
    acts_as_api

    api_accessible :base do |t|
      t.add :id
      t.add :rating
      t.add :recipe_id
      t.add :user_id
      t.add :body
    end

    ## ----------------------- Consumer Response ---------------------- ##

    api_accessible :index, extend: :base

    api_accessible :show, extend: :base

    ## ----------------------- Admin Response ------------------------- ##
  end
end
