# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'recipe_requests/edit', type: :view do
  before do
    @recipe_request = assign(:recipe_request, RecipeRequest.create!(
                                                new: 'MyString'
                                              ))
  end

  it 'renders the edit recipe_request form' do
    render

    assert_select 'form[action=?][method=?]', recipe_request_path(@recipe_request), 'post' do
      assert_select 'input[name=?]', 'recipe_request[new]'
    end
  end
end
