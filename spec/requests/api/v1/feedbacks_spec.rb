# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Feedbacks', type: :request do
  let!(:recipe) { create(:recipe) }
  let!(:endpoint) { "/api/v1/recipes/#{recipe.id}/feedbacks" }
  let!(:user) { create(:user) }
  let(:feedback) { create(:feedback, recipe: recipe) }

  describe 'GET /index' do
    context 'when success' do
      before do
        feedback
        get(endpoint)
      end

      it 'returns success' do
        expect(response).to have_http_status(:ok)
      end

      it 'returns success message' do
        expect(message_response).to eq('Data found')
      end

      it 'returns collection data' do
        expect(data_response[:feedbacks]).to eq([
                                                  {
                                                    'id'        => feedback.id,
                                                    'rating'    => feedback.rating,
                                                    'body'      => feedback.body,
                                                    'recipe_id' => recipe.id,
                                                    'user_id'   => feedback.user_id
                                                  }
                                                ])
      end

      it 'returns 1 record' do
        expect(data_response[:feedbacks].size).to eq(1)
      end

      it 'return feedbacks related to provided recipe ID' do
        expect(data_response[:feedbacks].pluck(:recipe_id)).to eq([recipe.id])
      end
    end
  end

  context 'when no feedbacks found' do
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
      expect(data_response[:feedbacks].size).to eq(0)
    end
  end

  describe 'POST /create' do
    let!(:valid_params) do
      { feedback: { comment: 'Its tasty Chicken baryani and easy to prepare', rating: 4 } }
    end

    context 'when success' do
      before do
        post(endpoint, params: valid_params, headers: request_headers(user))
      end

      it 'returns success' do
        expect(response).to have_http_status(:ok)
      end

      it 'returns success message' do
        expect(message_response).to eq('Feedback created successfully')
      end

      it 'return created comment' do
        expect(data_response[:feedback][:body]).to eq('Its tasty Chicken baryani and easy to prepare')
      end

      it 'returns 4 rating' do
        expect(data_response[:feedback][:rating]).to eq(4)
      end
    end

    context 'when failure' do
      it 'returns missing name' do
        valid_params[:feedback].delete(:comment)
        post(endpoint, params: valid_params, headers: request_headers(user))
        expect(message_response).to eq("Comment can't be blank")
      end

      it 'returns unauthorize' do
        post(endpoint, params: valid_params)
        expect(message_response).to eq('Missing Parameters: Authorization')
      end
    end
  end
end
