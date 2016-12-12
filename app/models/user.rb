class User < ApplicationRecord
  validates :email, uniqueness: true, presence: true, format: /\A[^@\s]+@([^@\s]+\.)+[^@\W]+\z/, case_sensitive: false
end
