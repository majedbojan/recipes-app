# frozen_string_literal: true

# == Schema Information
#
# Table name: tags
#
#  id         :uuid             not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  recipe_id  :uuid
#
# Indexes
#
#  index_tags_on_name_and_recipe_id  (name,recipe_id) UNIQUE
#  index_tags_on_recipe_id           (recipe_id)
#
# Foreign Keys
#
#  fk_rails_...  (recipe_id => recipes.id) ON DELETE => nullify
#
FactoryBot.define do
  factory :tag do
    recipe
    name { Faker::Name.name }
  end
end
