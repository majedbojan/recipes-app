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
#  index_recipes_on_LOWER_name  (lower((name)::text)) UNIQUE
#  index_recipes_on_status      (status)
#  index_recipes_on_user_id     (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id) ON DELETE => nullify
#
FactoryBot.define do
  factory :recipe do
    name { Faker::FunnyName.two_word_name }
    budget { 1 }
    difficulty { 1 }
    cook_time { '10 min' }
    prep_time { '20 min' }
    people_quantity { 2 }
    user
  end
end
