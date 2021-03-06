# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                     :uuid             not null, primary key
#  current_sign_in_at     :datetime
#  current_sign_in_ip     :integer
#  email                  :string           not null
#  encrypted_password     :string           not null
#  last_sign_in_at        :datetime
#  last_sign_in_ip        :integer
#  name                   :string           not null
#  phone                  :string
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  role                   :integer          default("user"), not null
#  sign_in_count          :integer          default(0), not null
#  status                 :integer          default("active"), not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_LOWER_email           (lower((email)::text)) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_status                (status)
#
class User < ApplicationRecord
  include UserPresenter

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable

  validates :name, presence: true
  validates :phone, phone: true, allow_nil: true

  enum role: {
    user:  0,
    admin: 1
  }

  enum status: {
    inactive: 0,
    active:   1
  }

  def self.login(email, password)
    user = User.find_for_authentication(email: email.downcase)
    return false if user.blank? || user.encrypted_password.nil?
    return user if user.valid_password?(password)

    false
  end

  # Only login active users
  def self.find_for_authentication(tainted_conditions)
    find_first_by_auth_conditions(tainted_conditions, status: :active)
  end

  def login_payload
    {
      id:    id,
      name:  name,
      role:  role,
      email: email
    }
  end

  ransack_alias :search, :name_or_email_or_phone
end
