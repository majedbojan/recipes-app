# frozen_string_literal: true

# == Schema Information
#
# Table name: tags
#
#  id         :uuid             not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  recipe_id  :uuid             not null
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
require 'rails_helper'

RSpec.describe Tag, type: :model do
  describe '#Tag' do
    subject(:tag) { build(:tag) }

    context 'when associating' do
      it { is_expected.to belong_to(:recipe) }
    end

    describe 'when validating' do
      it { is_expected.to validate_uniqueness_of(:name).scoped_to(:recipe_id) }

      it { is_expected.to validate_presence_of(:name) }
    end
  end
end
