# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Sessions', type: :request do
  # let!(:recipe) { create(:recipe) }
  let!(:endpoint) { '/api/v1/sessions' }
  let!(:user) { create(:user) }
  # let(:feedback) { create(:feedback, recipe: recipe) }

  describe 'POST /create' do
    let!(:valid_params) do
      { email: user.email, password: 'password' }
    end

    context 'when valid credentials' do
      before do
        post(endpoint, params: valid_params)
      end

      it 'returns success' do
        expect(response).to have_http_status(:ok)
      end

      it 'returns success message' do
        expect(message_response).to eq('User logged in successfully')
      end

      it 'responds with JSON with JWT token' do
        expect(data_response[:token]).not_to be(nil)
      end

      it 'responds with legedin user info' do
        expect(data_response[:user]).to eq(
          {
            'id'    => user.id,
            'name'  => user.name,
            'role'  => 'user',
            'email' => user.email,
            'phone' => user.phone
          }
        )
      end
    end

    context 'when invalid credentials' do
      it 'returns missing email params' do
        valid_params.delete(:email)
        post(endpoint, params: valid_params)
        expect(message_response).to eq('Missing Parameters: email')
      end

      it 'returns missing email password' do
        valid_params.delete(:password)
        post(endpoint, params: valid_params)
        expect(message_response).to eq('Missing Parameters: password')
      end

      it 'returns account not found' do
        post(endpoint, params: { email: 'wrong@example', password: 'password' })
        expect(message_response).to eq('User account not found')
      end
    end
  end
end
