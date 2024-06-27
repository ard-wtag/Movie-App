class UsersController < ApplicationController
  layout 'user_dashboard', except: [:login, :attempt_login,:new,:create]
  before_action :confirm_logged_in, except: [:login, :attempt_login]
  before_action :set_user, only: [:show, :edit, :update, :delete, :destroy]

  def index
    @users = User.all
  end

  def show
    @reviews = @user.reviews
    @followers_count = @user.followers.count
    @followees_count = @user.followees.count
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "User was successfully created."
      session[:user_id] = @user.id
      redirect_to @user
    else
      flash.now[:alert] = "Failed to create user."
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:notice] = "User was successfully updated."
      redirect_to user_path(@user)
    else
      flash.now[:alert] = "Failed to update user."
      render :edit
    end
  end

  def delete
  end

  def destroy
    if @user.destroy
      flash[:notice] = "User was successfully deleted."
      
      if session[:admin_user_id]
        # Redirect to users index if admin deletes the user
        redirect_to users_path
      else
        # Redirect to login if a user deletes their own profile
        redirect_to login_users_path
      end
    else
      redirect_to user_path(@user), alert: 'Failed to delete user.'
    end
  end

  def login
    # login form will load
  end

  def attempt_login
    if params[:email].present? && params[:password].present?
      found_user = User.find_by(email: params[:email])
      if found_user && found_user.authenticate(params[:password])
        session[:user_id] = found_user.id
        flash[:notice] = "You are now logged in."
        redirect_to user_path(found_user)
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
    session[:user_id] = nil
    flash[:notice] = "Logged out successfully."
    redirect_to login_users_path
    self.class.layout nil  # Clear layout after logout
  end
  

  private

  def set_user
    @user = User.find(params[:id])
  end

  def confirm_logged_in
    unless session[:user_id] || session[:admin_user_id]
      flash[:alert] = "Please log in."
      redirect_to login_users_path
    end
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :user_name, :email, :phone_no, :password, :password_confirmation)
  end
end
