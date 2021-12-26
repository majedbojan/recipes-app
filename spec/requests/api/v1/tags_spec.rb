# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Tags', type: :request do
  let!(:endpoint) { '/api/v1/tags' }

  let!(:recipe) { create(:recipe) }
  let(:tag) { create(:tag, recipe: recipe) }

  describe 'GET /index' do
    context 'when success' do
      before do
        tag
        get(endpoint)
      end

      it 'returns success' do
        expect(response).to have_http_status(:ok)
      end

      it 'returns success message' do
        expect(message_response).to eq('Data found')
      end

      it 'returns collection data' do
        expect(data_response[:tags]).to eq([
                                             { 'id'        => tag.id,
                                               'name'      => tag.name,
                                               'recipe_id' => recipe.id }
                                           ])
      end

      it 'returns 2 records' do
        expect(data_response[:tags].size).to eq(1)
      end
    end

    context 'when filtering' do
      before { tag }

      it 'filters by recipe ID' do
        get("#{endpoint}?recipe_id=#{recipe.id}")
        expect(data_response[:tags].pluck(:recipe_id)).to eq([recipe.id])
      end

      it 'filters by tag ID' do
        get("#{endpoint}?id=#{recipe.id}")
        expect(data_response[:tags].pluck(:id)).to eq([tag.id])
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
      expect(data_response[:tags].size).to eq(0)
    end
  end
end
