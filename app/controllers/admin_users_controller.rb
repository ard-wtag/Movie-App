class AdminUsersController < ApplicationController

  layout 'admin_dashboard', except: [:login, :attempt_login]
  before_action :confirm_logged_in, except: [:login, :attempt_login]

  def index
    #admin home page
  end

  def show
    @movie = Movie.find(params[:id])
    @reviews = @movie.reviews.includes(:user)  

    if @reviews.any?
      n = @reviews.length
      sum = @reviews.sum(&:rating)
      @average_rating = sum.to_f / n
    else
      @average_rating = 0
    end

  end 

  def new
    @movie=Movie.new
  end

  def create
    @movie=Movie.new(movie_params)
    if @movie.save
      redirect_to movielist_admin_users_path, notice: 'Movie was successfully created.'
    else
      render :new
    end
      
  end

  def edit
    @movie = Movie.find(params[:id])
  end

  def update
    @movie = Movie.find(params[:id])
    if @movie.update(movie_params)
      redirect_to movielist_admin_users_path, notice: 'Movie was successfully updated.'
    else
      render :edit
    end
  end




  def userlist
    @users=User.all 
  end 

  def show_user_details
    @user = User.find(params[:id])
    @reviews = @user.reviews
    @followers_count = @user.followers.count
    @followees_count = @user.followees.count
  end

  def confirm_user_delete
    @user = User.find(params[:id])
  end

  def confirm_user_destroy
    @user = User.find(params[:id])

    if @user.destroy 
      flash[:notice] = "User was successfully deleted."
      redirect_to userlist_admin_users_path
    else 
      redirect_to userlist_admin_users_path, alert: 'Failed to delete movie.'
    end

  end  

  def movielist
    @movies=Movie.sorted_by_title
  end

  def confirm_movie_delete
    @movie = Movie.find(params[:id])
  end

  def confirm_movie_destroy
    @movie = Movie.find(params[:id])
    if @movie.destroy
      redirect_to movielist_admin_users_path, notice: 'Movie was successfully deleted.'
    else
      redirect_to movielist_admin_users_path, alert: 'Failed to delete movie.'
    end
  end

  def login
    #loads the login form 
  end


  def attempt_login

    if params[:email].present? && params[:password].present?
      found_user = AdminUser.find_by(email: params[:email])
      if found_user && found_user.authenticate(params[:password])
        session[:admin_user_id] = found_user.id
        flash[:notice] = "You are now logged in."
        redirect_to root_path
      else
        flash.now[:alert] = "Invalid email/password combination."
        render :login
      end
    else
      flash.now[:alert] = "Email and password cannot be blank."
      render :login
    end

  end

  def logout
    session[:admin_user_id] = nil
    flash[:notice] = "Logged out successfully."
    redirect_to admin_login_path
  end

  private

  def movie_params
    params.require(:movie).permit(:title, :release_date, :director, :synopsis)
  end

  def confirm_logged_in
    unless session[:admin_user_id]
      flash[:alert] = "Please log in."
      redirect_to admin_login_path
    end
  end


end
