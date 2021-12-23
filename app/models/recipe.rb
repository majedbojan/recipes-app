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
class Recipe < ApplicationRecord
  include Activatable

  has_many   :recipe_tags, dependent: :destroy
  has_many   :tags, through: :recipe_tags, dependent: :destroy

  has_many   :recipe_ingredients, dependent: :destroy
  has_many   :ingredients, through: :recipe_ingredients, dependent: :destroy
  has_many   :comments, dependent: :destroy

  belongs_to :user, optional: true

  validates :name, presence: true

  enum budget: {
    cheap:           0,
    average_cost:    1,
    quite_expensive: 2
  }

  enum difficulty: {
    very_easy:     0,
    easy:          1,
    average_level: 2,
    difficult:     3
  }

  validates :name, presence: true
  validates :budget, presence: true
  validates :difficulty, presence: true
  validates :prep_time, presence: true


  scope :recipe_budget, ->(str) do
    case str
    when 'cheap'
      cheap
    when 'average_cost'
      average_cost
    when 'quite_expensive'
      quite_expensive
    end
  end

  def self.ransackable_scopes(_auth_object = nil)
    [:recipe_budget]
  end

  def rate_percentage
    ((20.0 / 10.0) * 100).round(1)
  end

  def total_time
    25
  end

  def budget_fr
    I18n.t("budget.#{budget}", locale: :fr)
  end

  def difficulty_fr
    I18n.t("difficulty.#{difficulty}", locale: :fr)
  end

  # private
end
