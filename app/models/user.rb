class User < ApplicationRecord
  has_many :domains, dependent: :destroy
  has_many :sessions, dependent: :destroy

  alias_attribute :email, :email_address
  has_secure_password
  normalizes :email_address, with: -> { it.strip.downcase }
  pay_customer default_payment_processor: :stripe

  validates :password, length: { minimum: 8 }, on: :create
end
