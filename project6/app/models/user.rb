class User < ApplicationRecord
    before_save { self.email = email.downcase }
    validates :name, presence: true, length: { maximum: 50 }
    VALID_EMAIL_REGEX = /\A[a-zA-Z]+\.\d+@[oO][sS][uU]\.[eE][dD][uU]\z/;
    validates :email, presence: true, length: { maximum: 255 },
                      format: { with: VALID_EMAIL_REGEX }, #FIXME: Might need to add buckeyemail
                      uniqueness: { case_sensitive: false }
    has_secure_password
    validates :password, presence: true, length: { minimum: 6 }
    validates :status, presence: true
end
