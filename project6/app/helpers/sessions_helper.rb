module SessionsHelper

    # Logs in the given user
    def log_in(user)
        session[:user_id] = user.id;
    end

    # Returns the current logged-in user, if any
    def current_user
        if (session[:user_id])
            @current_user = @current_user || User.find_by(id: session[:user_id]);
        end
    end

    # Returns true if the user is a student, false otherwise
    def isStudent?(user)
        if (user.status == "Student")
            return true;
        else
            return false;
        end
    end

    # Returns true if the user is a teacher, false otherwise
    def isTeacher?(user)
        if (user.status == "Employee")
            return true;
        else
            return false;
        end
    end

    # Returns true if the user is an admin, false otherwise
    def isAdmin?(user)
        user.status == "Admin";
    end

    # Returns true if the user is logged in, false otherwise
    def logged_in?
        !current_user.nil?;
    end

    def log_out
        session.delete(:user_id);
        @current_user = nil;
    end
end
