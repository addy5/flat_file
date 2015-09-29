class User < ActiveRecord::Base
  has_secure_password

  validates :email, presence: true, uniqueness: true
  # (validates: inserts into record only if there is an email)
  # (uniqueness: checks for existing email
  has_and_belongs_to_many :posts
end
