# frozen_string_literal: true

# == Schema Information
#
# Table name: recipe_ingredients
#
#  id            :uuid             not null, primary key
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  ingredient_id :uuid
#  recipe_id     :uuid
#
# Indexes
#
#  index_recipe_ingredients_on_ingredient_id  (ingredient_id)
#  index_recipe_ingredients_on_recipe_id      (recipe_id)
#
# Foreign Keys
#
#  fk_rails_...  (ingredient_id => ingredients.id) ON DELETE => nullify
#  fk_rails_...  (recipe_id => recipes.id) ON DELETE => nullify
#
class RecipeIngredient < ApplicationRecord
  belongs_to :recipe
  belongs_to :ingredient
end
