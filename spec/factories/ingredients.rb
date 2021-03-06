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
FactoryBot.define do
  factory :ingredient do
    recipe
    name { Faker::Name.name }
  end
end
