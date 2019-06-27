class User < ApplicationRecord
  has_secure_password

  has_many :repositories

  validates :name, :username, :email, presence: true
  validates :username, :email, uniqueness: true
  validates_format_of :email, with: /\A[^@]+@([^@\.]+\.)+[^@\.]+\z/
end
