class User < ApplicationRecord
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :password, presence: true
  validates :email, uniqueness: true, presence: true
end
