# frozen_string_literal: true

# == Schema Information
#
# Table name: recipes
#
#  id              :uuid             not null, primary key
#  budget          :integer          not null
#  cook_time       :string           not null
#  difficulty      :integer          not null
#  image_url       :string           not null
#  name            :string           not null
#  people_quantity :integer
#  prep_time       :string           not null
#  status          :integer          default("active"), not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  user_id         :uuid
#
# Indexes
#
#  index_recipes_on_status   (status)
#  index_recipes_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id) ON DELETE => nullify
#
require 'rails_helper'

RSpec.describe Recipe, type: :model do
  subject(:recipe) { build(:recipe) }

  describe 'validation' do
    it { is_expected.to validate_presence_of(:name) }
    # it { is_expected.to validate_presence_of(:capacity) }
    # it { is_expected.to validate_presence_of(:date) }
    # it { is_expected.to validate_presence_of(:time) }
  end
end
