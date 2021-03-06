# frozen_string_literal: true

# model for users
class User < ApplicationRecord
  has_many :students
  has_many :professors

  VALID_OSU_EMAIL = /[a-zA-Z]+\.[0-9]+@[oO][sS][uU]\.[eE][dD][uU]/.freeze

  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 }, format: { with: VALID_OSU_EMAIL }, uniqueness: true
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }
end
