class SessionsController < ApplicationController
  before_filter :require_sign_out, :except => :destroy

  def new
  end

  def create
    user = User.authenticate(params[:email], params[:password])
    if user
      sign_in user
      cookies.permanent.signed[:remember_token] = [user.id, user.remember_token]  if params[:remember_me]
      redirect_to session[:return_to] || root_url, :notice => "Success logged in!"
    else
      flash.now.notice = I18n.t('errors.messages.invalid_email_or_password')
      render "new"
    end
  end

  #退出登录
  def destroy
    sign_out
    redirect_to login_path, notice: I18n.t('layouts.logout_success')
  end
end
