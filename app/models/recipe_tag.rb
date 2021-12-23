# frozen_string_literal: true

# == Schema Information
#
# Table name: recipe_tags
#
#  id         :uuid             not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  recipe_id  :uuid
#  tag_id     :uuid
#
# Indexes
#
#  index_recipe_tags_on_recipe_id  (recipe_id)
#  index_recipe_tags_on_tag_id     (tag_id)
#
# Foreign Keys
#
#  fk_rails_...  (recipe_id => recipes.id) ON DELETE => nullify
#  fk_rails_...  (tag_id => tags.id) ON DELETE => nullify
#
class RecipeTag < ApplicationRecord
  belongs_to :recipe
  belongs_to :tag
end
