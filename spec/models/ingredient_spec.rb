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
require 'rails_helper'

RSpec.describe Ingredient, type: :model do
  describe '#Ingredient' do
    subject(:tag) { build(:tag) }

    context 'when associating' do
      it { is_expected.to belong_to(:recipe) }
    end

    context 'when validating' do
      it { is_expected.to validate_uniqueness_of(:name).scoped_to(:recipe_id) }

      it { is_expected.to validate_presence_of(:name) }
    end
  end
end
