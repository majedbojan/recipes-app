# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Ingredients', type: :request do
  let!(:endpoint) { '/api/v1/ingredients' }

  let!(:recipe) { create(:recipe) }
  let(:ingredient) { create(:ingredient, recipe: recipe) }

  describe 'GET /index' do
    context 'when success' do
      before do
        ingredient
        get(endpoint)
      end

      it 'returns success' do
        expect(response).to have_http_status(:ok)
      end

      it 'returns success message' do
        expect(message_response).to eq('Data found')
      end

      it 'returns collection data' do
        expect(data_response[:ingredients]).to eq([
                                                    { 'id'        => ingredient.id,
                                                      'name'      => ingredient.name,
                                                      'recipe_id' => recipe.id }
                                                  ])
      end

      it 'returns 2 records' do
        expect(data_response[:ingredients].size).to eq(1)
      end
    end

    context 'when filtering' do
      before { ingredient }

      it 'filters by recipe ID' do
        get("#{endpoint}?recipe_id=#{recipe.id}")
        expect(data_response[:ingredients].pluck(:recipe_id)).to eq([recipe.id])
      end

      it 'filters by ingredient ID' do
        get("#{endpoint}?id=#{recipe.id}")
        expect(data_response[:ingredients].pluck(:id)).to eq([ingredient.id])
      end
    end
  end

  context 'when no data found' do
    before do
      get(endpoint)
    end

    it 'returns success' do
      expect(response).to have_http_status(:ok)
    end

    it 'returns success message' do
      expect(message_response).to eq('No data found')
    end

    it 'returns 0 records' do
      expect(data_response[:ingredients].size).to eq(0)
    end
  end
end
