# frozen_string_literal: true

# == Schema Information
#
# Table name: feedbacks
#
#  id         :uuid             not null, primary key
#  comment    :text
#  rating     :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  recipe_id  :uuid             not null
#  user_id    :uuid             not null
#
# Indexes
#
#  index_feedbacks_on_comment                (comment) WHERE (comment IS NOT NULL)
#  index_feedbacks_on_rating                 (rating)
#  index_feedbacks_on_recipe_id              (recipe_id)
#  index_feedbacks_on_recipe_id_and_user_id  (recipe_id,user_id) UNIQUE
#  index_feedbacks_on_user_id                (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (recipe_id => recipes.id) ON DELETE => nullify
#  fk_rails_...  (user_id => users.id) ON DELETE => nullify
#
require 'rails_helper'

RSpec.describe Feedback, type: :model do
  describe '#Feedback' do
    subject(:feedback) { build(:feedback) }

    context 'when associating' do
      it { is_expected.to belong_to(:user) }
      it { is_expected.to belong_to(:recipe) }
    end

    context 'when validating' do
      it { is_expected.to validate_presence_of(:comment) }
      it { is_expected.to validate_presence_of(:recipe) }
      it { is_expected.to validate_presence_of(:user) }
    end
  end
end
