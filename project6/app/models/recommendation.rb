class Recommendation < ApplicationRecord
    belongs_to :user, required: false
    validates :name, presence: true, length: { maximum: 50 }
    VALID_EMAIL_REGEX = /\A[a-zA-Z]+\.\d+@[oO][sS][uU]\.[eE][dD][uU]\z/;
    validates :email, presence: true, length: { maximum: 255 },
                      format: { with: VALID_EMAIL_REGEX } #FIXME: Might need to add buckeyemail
    VALID_COURSE_NAME_REGEX = /\A[cC][sS][eE] \d{4}(\.01)?\z/;
    validates :course, presence: true, length: { maximum: 15 },
                            format: { with: VALID_COURSE_NAME_REGEX }
    VALID_SECTION_REGEX = /(\A\z|\d+\z)/;
    validates :section, length: { maximum: 20 },
                        format: { with: VALID_SECTION_REGEX },
                        uniqueness: true
end
