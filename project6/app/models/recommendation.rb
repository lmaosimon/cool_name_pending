class Recommendation < ApplicationRecord
    belongs_to :user, required: false
    validates :name, presence: true, length: { maximum: 50 }
    VALID_EMAIL_REGEX = /\A[a-zA-Z]+\.\d+@[oO][sS][uU]\.[eE][dD][uU]\z/;
    validates :email, presence: true, length: { maximum: 255 },
                      format: { with: VALID_EMAIL_REGEX }
    VALID_COURSE_NAME_REGEX = /\A[cC][sS][eE] \d{4}(\.01)?\z/;
    validates :course, presence: true, length: { maximum: 15 },
                            format: { with: VALID_COURSE_NAME_REGEX }
    VALID_SECTION_REGEX = /(\A\z|\d+\z)/;
    validates :section, length: { maximum: 20 },
                        format: { with: VALID_SECTION_REGEX }
    validate :status_auth

    private
        def status_auth
            agent = Mechanize.new;
            page = agent.get('https://www.osu.edu/findpeople/');
            form = page.form_with(:id => 'myform');

            atIndex = self.email.index("@");
            if (atIndex.nil?)
                errors.add(:email, "does not contain a valid name.number");
            else
                nameDotNum = self.email[0...atIndex];
                form.name_n = nameDotNum;

                result_page = form.submit;

                if (result_page.search(".notification.success").empty?)
                    errors.add(:email, "does not contain a valid OSU name.number");
                end
            end
        end
end
