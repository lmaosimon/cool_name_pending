class Course < ApplicationRecord
    belongs_to :user, required: false
    has_and_belongs_to_many :grader_application, required: false

    validates :instructor, presence: true, length: { maximum: 50 }
    VALID_EMAIL_REGEX = /\A[a-zA-Z]+\.\d+@[oO][sS][uU]\.[eE][dD][uU]\z/;
    validates :email, presence: true, length: { maximum: 255 },
                      format: { with: VALID_EMAIL_REGEX } #FIXME: Might need to add buckeyemail
    VALID_COURSE_NAME_REGEX = /\A[cC][sS][eE] \d{4}(\.01)?\z/;
    validates :course_name, presence: true, length: { maximum: 15 },
                            format: { with: VALID_COURSE_NAME_REGEX }
    VALID_SECTION_REGEX = /\A\d+\z/;
    validates :section, presence: true, length: { maximum: 20 },
                        format: { with: VALID_SECTION_REGEX },
                        uniqueness: true
    VALID_TIME_REGEX = /\A((1[0-2]|0?[1-9]):([0-5][0-9]) ([AaPp][Mm]))\z/;
    validates :start_time, presence: true, length: { maximum: 8 },
                           format: { with: VALID_TIME_REGEX }
    validates :end_time, presence: true, length: { maximum: 8 },
                         format: { with: VALID_TIME_REGEX }
    validate :valid_time_range

    private
        # Function to validate that a valid time range was given
        def valid_time_range
            # Downcase am or pm in start_time and end_time
            first = self.start_time.downcase;
            second = self.end_time.downcase;

            # Get the index of the colon in start_time and end_time
            first_colon = first.index(":");
            second_colon = second.index(":");

            # If input does not match regexp, do not go in if-statement block
            if (!first.nil? && !first_colon.nil?)
                # Get the hour of both start_time and end_time
                first_hour = first[0...first_colon];
                second_hour = second[0...second_colon];

                # Get am or pm for both start_time and end_time
                first = first[(first.size - 2)...(first.size)];
                second = second[(second.size - 2)...(second.size)];

                # No classes should ever begin at night and end in morning, return false
                if (first == "pm" && second == "am")
                    errors.add(:start_time, "and end time are an invalid range");
                # If both in am, then invalid range when first_hour > second_hour
                elsif (first == "am" && second == "am" && first_hour.to_i > second_hour.to_i)
                    errors.add(:start_time, "and end time are an invalid range");
                # If both in pm, then invalid range when first_hour > second_hour
                elsif (first == "pm" && second == "pm" && first_hour.to_i > second_hour.to_i)
                    errors.add(:start_time, "and end time are an invalid range");
                end
            end

            return true;
        end
end
