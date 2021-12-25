# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'recipe_requests/show', type: :view do
  before do
    @recipe_request = assign(:recipe_request, RecipeRequest.create!(
                                                new: 'New'
                                              ))
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(/New/)
  end
end
