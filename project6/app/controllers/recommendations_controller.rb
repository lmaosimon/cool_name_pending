class RecommendationsController < ApplicationController
  before_action :logged_in_teacher, only: [:new, :index, :create, :destroy, :edit, :update ]
  before_action :correct_user, only: [:new, :index, :create, :destroy, :edit, :update ]
  def new
    @recommendation = Recommendation.new;
  end

  def index
    @recommendations = current_user.recommendations;
  end

  def admin_index
    @recommendations = Recommendation.all;
  end

  def create
    @recommendation = Recommendation.new(recommendation_params);
    if @recommendation.save
      flash[:success] = "Recommendation successfully added to list of Recommendations!"
      current_user.recommendations << @recommendation;
      redirect_to recommendations_url;
    else
      render 'new'
    end
  end

  def destroy
    Recommendation.find(params[:id]).destroy;
    flash[:success] = "Recommendation deleted";
    if (current_user.admin?)
      redirect_to allrecommendations_url;
    else
      redirect_to recommendations_url;
    end
  end

  def edit
    @recommendation = Recommendation.find(params[:id]);
    # Stops one teacher from updating another teacher's courses
    if (@recommendation.user_id != current_user.id && !current_user.admin?)
      redirect_to current_user;
      flash[:danger] = "You are not authorized to access another teacher's recommendations."
    end
  end

  def update
    @recommendation = Recommendation.find(params[:id]);
    if (@recommendation.update_attributes(recommendation_params))
      flash[:success] = "Recommendation updated";
      if (current_user.admin?)
        redirect_to allrecommendations_url;
      else
        redirect_to recommendations_url;
      end
    else
      render 'edit'
    end
  end

  private
    def recommendation_params
      params.require(:recommendation).permit(:name, :email, :course, :section);
    end

    def logged_in_teacher
      unless logged_in? && isTeacher?(current_user)
        if (isStudent?(current_user))
          flash[:danger] = "Students are not authorized to access this page.";
          redirect_to current_user;
        else
          flash[:danger] = "You must be logged in as a teacher to view this page."
          redirect_to login_url
        end
      end
    end

    def correct_user
      redirect_to(current_user) unless current_user?(current_user)
    end
end
