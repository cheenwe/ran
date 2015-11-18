class SessionController < ApplicationController
  skip_before_action :authenticate_login

  def new
    @user = User.new
  end

  def create
    @user = User.new.authenticate(params[:user][:name], params[:user][:password])

    unless @user.nil?
      if params[:remember_me] == 'true'
        @user.refresh_remember_token
        cookies[:auth_token] = { :value => @user.remember_token, :expires => 2.weeks.from_now }
      end

      session[:user_id] = @user.id
      redirect_url = session.delete(:return_to) || users_url
      redirect_to redirect_url, :only_path => true, :notice => t("session.login_success")
    else
      log_failed_sign_in_attempt(Time.now, params[:name], request.remote_ip)
      redirect_to new_session_url, :alert => t("session.login_failure")
    end
  end

  def destroy
    current_user.refresh_remember_token
    cookies.delete :auth_token
    reset_session
    session[:user_id] = nil
    redirect_to new_session_url
  end

  private

  def log_failed_sign_in_attempt(date, name, ip)
    Rails.logger.error(
      "\nFAILED SIGN IN ATTEMPT:\n" +
      "=======================\n" +
      " Date: #{date}\n" +
      " Username: #{name}\n" +
      " IP address: #{ip}\n\n"
    )
  end
end
