require 'securerandom'

# class User < ApplicationRecord
#   has_secure_password

#   validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
#   validates :password, presence: true, length: { minimum: 6 }

#   before_create :set_uuid

#   private

#   def set_uuid
#     self.id = SecureRandom.uuid if id.blank?
#   end
# end

# app/models/user.rb
class User < ApplicationRecord
    has_secure_password
  
    validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
    validates :password, presence: true, length: { minimum: 6 }
    validates :password_confirmation, presence: true, if: :password_digest_changed?
  
    validate :password_confirmation_match, if: -> { password.present? }
  
    before_create :set_uuid
  
    private
  
    def set_uuid
      self.id = SecureRandom.uuid if id.blank?
    end
  
    def password_confirmation_match
      errors.add(:password_confirmation, "doesn't match Password") if password != password_confirmation
    end
  end
  
  