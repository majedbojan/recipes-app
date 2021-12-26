# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Recipes', type: :request do
  let!(:endpoint) { '/api/v1/recipes' }
  let!(:recipe) { create(:recipe) }
  let!(:second_recipe) { create(:recipe) }
  let!(:tag) { create(:tag, recipe: second_recipe) }
  let!(:ingredient) { create(:ingredient, recipe: second_recipe) }

  describe 'GET /index' do
    context 'when success' do
      before do
        get(endpoint)
      end

      it 'returns success' do
        expect(response).to have_http_status(:ok)
      end

      it 'returns success message' do
        expect(message_response).to eq('Data found')
      end

      it 'returns collection data' do
        expect(data_response[:recipes]).to eq([
                                                { 'id'              => second_recipe.id,
                                                  'name'            => second_recipe.name,
                                                  'image_url'       => nil,
                                                  'author_name'     => second_recipe.author_name,
                                                  'rate_percentage' => 200.0 },
                                                {
                                                  'id'              => recipe.id,
                                                  'name'            => recipe.name,
                                                  'image_url'       => nil,
                                                  'author_name'     => recipe.author_name,
                                                  'rate_percentage' => 200.0
                                                }
                                              ])
      end

      it 'returns 2 records' do
        expect(data_response[:recipes].size).to eq(2)
      end
    end

    context 'when filtering' do
      it 'returns recipes with matches provided tag IDs' do
        get("#{endpoint}?tag_ids[]=#{tag.id}")
        expect(data_response[:recipes]).to eq([
                                                { 'id'              => second_recipe.id,
                                                  'name'            => second_recipe.name,
                                                  'image_url'       => nil,
                                                  'author_name'     => second_recipe.author_name,
                                                  'rate_percentage' => 200.0 }
                                              ])
      end

      it 'returns recipes with matches provided ingredients IDs' do
        get("#{endpoint}?ingredient_ids[]=#{ingredient.id}")
        expect(data_response[:recipes]).to eq([
                                                { 'id'              => second_recipe.id,
                                                  'name'            => second_recipe.name,
                                                  'image_url'       => nil,
                                                  'author_name'     => second_recipe.author_name,
                                                  'rate_percentage' => 200.0 }
                                              ])
      end
    end
  end

  describe 'Get /show' do
    context 'when success' do
      before do
        get("#{endpoint}/#{second_recipe.id}")
      end

      it 'returns success' do
        expect(response).to have_http_status(:ok)
      end

      it 'returns success message' do
        expect(message_response).to eq('Data found')
      end

      it 'returns recipe object' do
        expect(data_response[:recipe]).to eq({ 'author_name'     => second_recipe.author_name,
                                               'budget'          => 'average_cost',
                                               'budget_fr'       => 'Coût moyen',
                                               'cook_time'       => '10 min',
                                               'difficulty'      => 'easy',
                                               'difficulty_fr'   => 'Niveau moyen',
                                               'feedbacks'       => [],
                                               'id'              => second_recipe.id,
                                               'image_url'       => nil,
                                               'name'            => second_recipe.name,
                                               'people_quantity' => 2,
                                               'rate_percentage' => second_recipe.rate_percentage,
                                               'ingredients'     => [{
                                                 'id'        => ingredient.id,
                                                 'name'      => ingredient.name,
                                                 'recipe_id' => second_recipe.id
                                               }],
                                               'tags'            => [{
                                                 'id'        => tag.id,
                                                 'name'      => tag.name,
                                                 'recipe_id' => second_recipe.id
                                               }] })
      end
    end

    context 'when failure' do
      before do
        get("#{endpoint}/081134d3-b679-xxxx-ac4b-xxxxxxx")
      end

      it 'returns not found' do
        expect(status_response).to eq('not_found')
      end
    end
  end

  describe 'POST /create' do
  end
end
