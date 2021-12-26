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

user_authors = User.pluck(:name, :id).to_h
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

Recipe.all.each do |recipe|
  find_recipe = recipes.find { |r| r['name'] == recipe.name }
  ## Tags
  if find_recipe && find_recipe['tags']
    tag_params = find_recipe['tags'].map { |tag| { name: tag, recipe_id: recipe.id }.merge(basic_params) }
    Tag.insert_all(tag_params)
  end

  next unless find_recipe && find_recipe['ingredients']

  ingredient_params = find_recipe['ingredients'].map do |ingredient|
    { name: ingredient, recipe_id: recipe.id }.merge(basic_params)
  end
  Ingredient.insert_all(ingredient_params)
end

## ----------------------------------------------------------------------------- ##

## Feedbacks

rand(1...5)
