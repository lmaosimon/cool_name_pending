class User < ApplicationRecord
    has_many :recommendations, dependent: :destroy # Can have many submitted recommendations if status is Faculty Employee
    has_one :grader_application, required: false
    has_many :courses, dependent: :destroy # Can have many courses if status is Faculty Employee
    before_save { self.email = email.downcase }
    validates :name, presence: true, length: { maximum: 50 }
    VALID_EMAIL_REGEX = /\A[a-zA-Z]+\.\d+@[oO][sS][uU]\.[eE][dD][uU]\z/;
    validates :email, presence: true, length: { maximum: 255 },
                      format: { with: VALID_EMAIL_REGEX }, #FIXME: Might need to add buckeyemail
                      uniqueness: { case_sensitive: false }
    has_secure_password
    validates :password, presence: true, length: { minimum: 6 }
    validates :status, presence: true   
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
    
                if (!result_page.search(".notification.success").empty? && !self.status.nil?)
                    if (result_page.search(".results-affiliation").text.include?(self.status))
                        return true;
                    else
                        errors.add(:status, "is not valid for given OSU name.number in email");
                    end
                else
                    errors.add(:email, "does not contain a valid name.number");
                end
            end

        end
end
