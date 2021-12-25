# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).

# Total recipes are 9500, please feel free to import as less as you need
NO_OF_RECIPES = 100

FactoryBot.create(:user, email: 'admin@recipe.app', role: :admin)

basic_params = { created_at: Time.zone.now, updated_at: Time.zone.now }
recipes = JSON.parse(File.read('db/data/recipes.json')).first(NO_OF_RECIPES)

## ----------------------------------------------------------------------------- ##

# Authors
authors = recipes.map { |recipe| recipe['author'] }.uniq.flatten
author_params = authors.map do |author|
  { name: author, email: "#{author}-example.com", role: :user, encrypted_password: 'password' }.merge(basic_params)
end
User.insert_all(author_params)

## ----------------------------------------------------------------------------- ##
## Recipes
budgets = { 'bon marché' => 'cheap', 'Coût moyen' => 'average_cost', 'assez cher' => 'quite_expensive' }

difficulties = { 'très facile' => 'very_easy', 'Niveau moyen' => 'easy', 'facile' => 'average_level',
'difficile' => 'difficult' }

user_authors = users = User.pluck(:name, :id).to_h
recipes_params = recipes.map do |recipe|
  {
    budget:          budgets[recipe['budget']],
    prep_time:       recipe['prep_time'],
    name:            recipe['name'],
    difficulty:      difficulties[recipe['difficulty']],
    people_quantity: recipe['people_quantity'],
    cook_time:       recipe['cook_time'],
    image_url:       recipe['image'],
    user_id:         user_authors[recipe['author']]
  }.merge(basic_params)
end

Recipe.insert_all(recipes_params)

## ----------------------------------------------------------------------------- ##

## Tags
# tags = recipes.map { |recipe| recipe['tags'] }.flatten.uniq.compact.map { |tag| { name: tag }.merge(basic_params) }
# Tag.insert_all(tags)

## ----------------------------------------------------------------------------- ##
# Recipe Tags
# recipes.map do |recipe|
#   find_recipe = Recipe.find_by(name: recipe['name'])
#   find_tags = Tag.where(name: recipe['tags']).ids
#   recipe_tags_params = find_tags.map { |tag_id| {recipe_id: find_recipe.id, tag_id: tag_id}.merge(basic_params) }
#   RecipeTag.insert_all(recipe_tags_params)
# end
## ----------------------------------------------------------------------------- ##

## Ingredients
# ingredients = recipes.map { |recipe| recipe['ingredients'] }.flatten.uniq.compact.map do |ingredient|
#   { name: ingredient.to_s }.merge(basic_params)
# end

# Ingredient.insert_all(ingredients)

## ----------------------------------------------------------------------------- ##

# Recipe Ingredients
# recipes.map do |recipe|
#   find_recipe = Recipe.find_by(name: recipe['name'])
#   find_Ingredients = Ingredient.where(name: recipe['ingredients']).ids
#   recipe_Ingredients_params = find_Ingredients.map { |ingredient_id| {recipe_id: find_recipe.id, ingredient_id: ingredient_id}.merge(basic_params) }
#   RecipeIngredient.insert_all(recipe_Ingredients_params)
# end
