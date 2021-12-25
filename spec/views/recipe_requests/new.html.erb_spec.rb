# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'recipe_requests/new', type: :view do
  before do
    assign(:recipe_request, RecipeRequest.new(
                              new: 'MyString'
                            ))
  end

  it 'renders new recipe_request form' do
    render

    assert_select 'form[action=?][method=?]', recipe_requests_path, 'post' do
      assert_select 'input[name=?]', 'recipe_request[new]'
    end
  end
end
