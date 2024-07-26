# frozen_string_literal: true

# This is application controller
class ApplicationController < ActionController::Base
  helper_method :current_user, :current_admin, :logged_in?, :flash_class

  before_action :set_layout
  around_action :switch_locale

  private

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def current_admin
    @current_admin ||= User.find_by(id: session[:admin_user_id]) if session[:admin_user_id]
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
      self.class.layout 'application'
    end
  end

  def switch_locale(&action)
    logger.debug "* Accept-Language: #{request.env['HTTP_ACCEPT_LANGUAGE']}"
    locale = extract_locale_from_accept_language_header
    logger.debug "* Locale set to '#{locale}'"
    I18n.with_locale(locale, &action)
  end

  def extract_locale_from_accept_language_header
    locale = request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).first
    I18n.available_locales.map(&:to_s).include?(locale) ? locale : I18n.default_locale
  end

  def flash_class(level)
    case level
    when 'notice' then 'bg-green-500 text-white'
    when 'alert' then 'bg-red-500 text-white'
    else 'bg-yellow-500 text-white'
    end
  end
end
