class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user, :signed_in?

  class AccessDenied < Exception; end

  def signed_in?
    !current_user.nil?
  end

  def sign_in(user)
    session[:user_id] = user.id
    @current_user = user
  end

  #退出登录
  def sign_out
    session.delete(:user_id)
    cookies.delete(:remember_token)
    @current_user = nil
  end

  def current_user
    @current_user ||= login_from_session || login_from_cookie
  end

  def current_user?(user)
    current_user == user
  end

  def require_sign_in
    unless signed_in?
      store_location
      redirect_to login_url, notice: I18n.t('errors.messages.please_login_first')
    end
  end

  def require_sign_out
    if signed_in?
      redirect_to root_url
    end
  end


  def login_from_session
    if session[:user_id].present?
      begin
        User.find(session[:user_id])
      rescue
        session[:user_id] = nil
      end
    end
  end

  def login_from_cookie
    User.authenticate_with_token(*cookies.permanent.signed[:remember_token]) if cookies.permanent.signed[:remember_token]
  end

  def store_location(path = nil)
    session[:return_to] = path || request.fullpath
  end


end
