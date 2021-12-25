# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'recipe_requests/index', type: :view do
  before do
    assign(:recipe_requests, [
             RecipeRequest.create!(
               new: 'New'
             ),
             RecipeRequest.create!(
               new: 'New'
             )
           ])
  end

  it 'renders a list of recipe_requests' do
    render
    assert_select 'tr>td', text: 'New'.to_s, count: 2
  end
end
