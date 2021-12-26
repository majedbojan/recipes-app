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
FactoryBot.define do
  factory :feedback do
    user
    recipe
    comment { Faker::Lorem.paragraph_by_chars(number: 150) }
    rating { rand(1...5) }
  end
end
