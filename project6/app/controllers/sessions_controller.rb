class SessionsController < ApplicationController
  # NOTE: Our implementation will log a user out if they exit the browser

  # Controller action for user login page
  def new
  end

  # Controller action for creating a new user session when a user logs in
  def create
    user = User.find_by(email: params[:session][:email].downcase);
    # If the log in fields contain a real users attributes, and the password is correct,
    # then log the user in and create a session for that user
    if (user && user.authenticate(params[:session][:password]))
      log_in(user);
      redirect_to(user);
    else
      flash.now[:danger] = "Invalid email/password combination";
      render 'new';
    end
  end

  # Controller action for deleting a user session when a user logs out
  def destroy
    log_out;
    redirect_to root_url;
  end
end
