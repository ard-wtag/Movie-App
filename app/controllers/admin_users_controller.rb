class AdminUsersController < ApplicationController

  layout 'admin_dashboard', except: [:login, :attempt_login]
  before_action :confirm_logged_in, except: [:login, :attempt_login]

  def index
    #admin home page
  end

  def show
  end 

  def new
  end

  def create
  end

  def edit
  end

  def update
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
    redirect_to login_admin_users_path
    self.class.layout nil  # Clear layout after logout
  end
  

  private

  def confirm_logged_in
    unless session[:admin_user_id]
      flash[:alert] = "Please log in."
      redirect_to login_admin_users_path
    end
  end

end
