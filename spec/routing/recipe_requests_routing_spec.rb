# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RecipeRequestsController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/recipe_requests').to route_to('recipe_requests#index')
    end

    it 'routes to #new' do
      expect(get: '/recipe_requests/new').to route_to('recipe_requests#new')
    end

    it 'routes to #show' do
      expect(get: '/recipe_requests/1').to route_to('recipe_requests#show', id: '1')
    end

    it 'routes to #edit' do
      expect(get: '/recipe_requests/1/edit').to route_to('recipe_requests#edit', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/recipe_requests').to route_to('recipe_requests#create')
    end

    it 'routes to #update via PUT' do
      expect(put: '/recipe_requests/1').to route_to('recipe_requests#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/recipe_requests/1').to route_to('recipe_requests#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/recipe_requests/1').to route_to('recipe_requests#destroy', id: '1')
    end
  end
end
