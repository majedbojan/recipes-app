# frozen_string_literal: true

# == Schema Information
#
# Table name: recipes
#
#  id              :uuid             not null, primary key
#  budget          :integer          not null
#  cook_time       :string           not null
#  difficulty      :integer          not null
#  image_url       :string
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
    it { is_expected.to validate_presence_of(:cook_time) }
    it { is_expected.to validate_presence_of(:budget) }
    it { is_expected.to validate_presence_of(:prep_time) }
    it { is_expected.to validate_presence_of(:difficulty) }
    it { is_expected.to validate_presence_of(:people_quantity) }

    it {
      expect(subject).to define_enum_for(:difficulty).with_values(very_easy: 0, easy: 1, average_level: 2, difficult: 3)
    }

    it {
      expect(subject).to define_enum_for(:budget).with_values(cheap:           0,
                                                              average_cost:    1,
                                                              quite_expensive: 2)
    }
  end
end
