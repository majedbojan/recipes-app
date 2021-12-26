# frozen_string_literal: true

# == Schema Information
#
# Table name: ingredients
#
#  id         :uuid             not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  recipe_id  :uuid             not null
#
# Indexes
#
#  index_ingredients_on_name_and_recipe_id  (name,recipe_id) UNIQUE
#  index_ingredients_on_recipe_id           (recipe_id)
#
# Foreign Keys
#
#  fk_rails_...  (recipe_id => recipes.id) ON DELETE => nullify
#
class Ingredient < ApplicationRecord
  include IngredientPresenter
  belongs_to :recipe, dependent: :destroy
  validates :name, presence: true, uniqueness: { scope: :recipe_id }
end
