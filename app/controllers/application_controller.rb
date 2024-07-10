# frozen_string_literal: true

# This is application controller
class ApplicationController < ActionController::Base
  helper_method :current_user, :current_admin, :logged_in?

  before_action :set_layout

  private

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def current_admin
    @current_admin ||=User.find_by(id: session[:admin_user_id]) if session[:admin_user_id]
  end

  def logged_in?
    current_user || current_admin
  end

  def authenticate_user!
    return if logged_in?

    if params[:controller].start_with?('admin')
      redirect_to login_admin_users_path, alert: 'Please log in as admin.'
    else
      redirect_to login_users_path, alert: 'Please log in.'
    end
  end

  def authenticate_admin!
    redirect_to login_admin_users_path, alert: 'Please log in as admin.' unless current_admin
  end

  def set_layout
    if logged_in?
      if current_admin
        self.class.layout 'admin_dashboard'
      else
        self.class.layout 'user_dashboard'
      end
    else
      self.class.layout nil # Clear layout if no user is logged in
    end
  end
end
