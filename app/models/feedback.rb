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
class Feedback < ApplicationRecord
  belongs_to :recipe
  belongs_to :user, optional: true

  has_rich_text :comment

  # validates :recipe, presence: true, uniqueness: { case_sensitive: false }
  # validates :user, presence: true, uniqueness: { case_sensitive: false }

  validates :rating,
            presence:     true,
            numericality: { only_integer:             true,
                            greater_than_or_equal_to: 1,
                            less_than_or_equal_to:    5 }
end
