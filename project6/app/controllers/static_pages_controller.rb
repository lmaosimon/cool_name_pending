class StaticPagesController < ApplicationController
  # Make sure only a non-logged in user can access the home page
  before_action :not_logged_in, only: [:home]

  # Controller action for displaying the home page
  def home
  end
  # Controller action for displaying the about page
  def about
  end

  private
    # Function to check if current user is not logged in, else redirect to the user's profile page
    def not_logged_in
      unless !logged_in?
        redirect_to current_user;
      end
    end

end
