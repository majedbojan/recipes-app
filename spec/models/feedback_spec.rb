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
#  recipe_id  :uuid
#  user_id    :uuid
#
# Indexes
#
#  index_feedbacks_on_comment    (comment) WHERE (comment IS NOT NULL)
#  index_feedbacks_on_rating     (rating)
#  index_feedbacks_on_recipe_id  (recipe_id)
#  index_feedbacks_on_user_id    (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (recipe_id => recipes.id) ON DELETE => nullify
#  fk_rails_...  (user_id => users.id) ON DELETE => nullify
#
require 'rails_helper'

RSpec.describe Feedback, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
