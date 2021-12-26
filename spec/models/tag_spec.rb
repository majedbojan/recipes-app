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
#  index_tags_on_name       (name)
#  index_tags_on_recipe_id  (recipe_id)
#
# Foreign Keys
#
#  fk_rails_...  (recipe_id => recipes.id) ON DELETE => nullify
#
require 'rails_helper'

RSpec.describe Tag, type: :model do
  subject(:tag) { build(:tag) }

  describe 'validation' do
    it { is_expected.to validate_presence_of(:name) }
  end
end
