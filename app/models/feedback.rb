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
class Feedback < ApplicationRecord
  include FeedbackPresenter
  belongs_to :recipe
  belongs_to :user

  has_rich_text :comment

  validates :rating,
            presence:     true,
            numericality: { only_integer:             true,
                            greater_than_or_equal_to: 1,
                            less_than_or_equal_to:    5 }

  validates :recipe, presence: true
  validates :user, presence: true
  validates :comment, presence: true
  validates :recipe_id, uniqueness: { scope: :user_id }

  def body
    JSON.parse(comment.body.to_json)
  end
end
