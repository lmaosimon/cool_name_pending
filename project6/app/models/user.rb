class User < ApplicationRecord

    # Can have many submitted recommendations if user status is Employee
    has_many :recommendations, dependent: :destroy
    # Can have one grader application if user status is Student
    has_one :grader_application, required: false, dependent: :destroy
    # Can have many courses if user status is Employee
    has_many :courses, dependent: :destroy
    # Belongs to a course if a student user is assigned to a course
    belongs_to :course, required: false

    before_save { self.email = email.downcase }
    validates :name, presence: true, length: { maximum: 50 }
    VALID_EMAIL_REGEX = /\A[a-zA-Z]+\.\d+@[oO][sS][uU]\.[eE][dD][uU]\z/;
    validates :email, presence: true, length: { maximum: 255 },
                      format: { with: VALID_EMAIL_REGEX },
                      uniqueness: { case_sensitive: false }
    has_secure_password
    validates :password, presence: true, length: { minimum: 6 }, :if => :password
    validates :status, presence: true 
    # Custom validation, explained below
    validate :status_auth

    private
        # Custom validation function to make sure when creating a user account that the user is an
        # actual OSU student or employee via their name.number, and to make sure that a student
        # isn't signing up as a teacher, and a teacher isn't signing up as a student. Uses mechanize.
        # NOTE: We know that students that have jobs on campus have a 'Student Employee' affilation,
        # so they can technically sign up as a teacher. But, we had to be able to allow someone with
        # that affilation to sign up as a teacher because, for example, a Systems 2 teacher,
        # Jayson Boubin, is a grad student so the only Employee affiliation he has is 'Student
        # Employee'. Thus, if we disallowed someone with the 'Student Employee' affilation to sign up
        # as a teacher, then him and other grad student teachers would not be able to sign up as
        # teachers to acquire graders. We could not find any other solution to fix this.
        def status_auth
            # Get the find people osu page and find the search form for looking up students/faculty
            agent = Mechanize.new;
            page = agent.get('https://www.osu.edu/findpeople/');
            form = page.form_with(:id => 'myform');

            # Check to make sure user gave valid @ in email. If they didn't then
            # we won't be able to get the name.number substring so there is no point
            # in searching for them in the find people directory 
            atIndex = self.email.index("@");
            if (atIndex.nil?)
                # User gave email input without @ so return and don't search
                return;
            else
                # Get the user's name.number. It's possible that they didn't include
                # a name.number in their email, but this error will be caught below
                # as well as in the regexp email validation above
                nameDotNum = self.email[0...atIndex];

                # Fill in the form with name.number and submit
                form.name_n = nameDotNum;
                result_page = form.submit;
    
                # If the search was successful, we should successfully find an element with classes
                # 'notification' and 'success', so we know that the user is a real person at OSU.
                # Also check to make sure the user clicked one of the status radio buttons.
                if (!result_page.search(".notification.success").empty? && !self.status.nil?)

                    # If the element with class 'results-affilation' includes Student or Employee text
                    # that corresponds with the Student or Teacher status that the user selected, then
                    # they are the status that they selected
                    if (result_page.search(".results-affiliation").text.include?(self.status))
                        return true;
                    # Otherwise, a student is trying to sign up as a teacher, or a teacher is trying
                    # to sign up as a student, so prevent them from signing up by generating an error
                    else
                        errors.add(:status, "is not valid for given OSU name.number in email");
                    end
                # If there was not a success message after a search, then the person either gave an
                # incorrect name.number, or they are not a real person affiliated with OSU, so prevent
                # them from signing up  by generating an error
                else
                    errors.add(:email, "does not contain a valid name.number");
                end
            end

        end
end
