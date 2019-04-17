class GraderApplication < ApplicationRecord
    belongs_to :user, required: false, dependent: :destroy
    has_and_belongs_to_many :courses, required: false

    validates :name, presence: true, length: { maximum: 50 }
    VALID_EMAIL_REGEX = /\A[a-zA-Z]+\.\d+@[oO][sS][uU]\.[eE][dD][uU]\z/;
    validates :email, presence: true, length: { maximum: 255 },
                      format: { with: VALID_EMAIL_REGEX }
    validates :qualifications, presence: true, length: { maximum: 240 }
    validate :course_selected
            
end
