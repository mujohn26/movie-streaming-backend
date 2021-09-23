require 'bcrypt'

module Hashes
  module PasswordHash
    def self.hash(password)
      BCrypt::Password.create(password)
    end
  end
end
