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
#  user_id         :uuid             not null
#
# Indexes
#
#  index_recipes_on_LOWER_name  (lower((name)::text)) UNIQUE
#  index_recipes_on_status      (status)
#  index_recipes_on_user_id     (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id) ON DELETE => nullify
#
class Recipe < ApplicationRecord
  include RecipePresenter

  has_many   :tags, dependent: :destroy
  has_many   :ingredients, dependent: :destroy

  has_many   :feedbacks, dependent: :destroy
  accepts_nested_attributes_for :tags,
                                allow_destroy: true,
                                reject_if:     proc { |att| att['name'].blank? }

  accepts_nested_attributes_for :ingredients,
                                allow_destroy: true,
                                reject_if:     proc { |att| att['name'].blank? }
  belongs_to :user, optional: true

  validates :name, presence: true, uniqueness: true
  validates :budget, presence: true
  validates :cook_time, presence: true
  validates :difficulty, presence: true
  validates :people_quantity, presence: true
  validates :prep_time, presence: true

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
  enum status: {
    pending:  0,
    active:   1,
    inactive: 2
  }
  scope :recipe_budget, lambda { |str|
    case str
    when 'cheap'
      cheap
    when 'average_cost'
      average_cost
    when 'quite_expensive'
      quite_expensive
    end
  }

  scope :recipe_difficulty, lambda { |str|
    case str
    when 'very_easy'
      cheap
    when 'easy'
      average_cost
    when 'average_level'
      quite_expensive
    when 'difficult'
      difficult
    end
  }

  def self.ransackable_scopes(_auth_object = nil)
    %i[recipe_budget recipe_difficulty]
  end

  def rate_percentage
    ((20.0 / 10.0) * 100).round(1)
  end

  def total_time
    # cook_time + prep_time
  end

  def budget_fr
    I18n.t("budget.#{budget}", locale: :fr)
  end

  def difficulty_fr
    I18n.t("difficulty.#{difficulty}", locale: :fr)
  end

  def author_name
    user&.name || 'admin'
  end

  # private
end
