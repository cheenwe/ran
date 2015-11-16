class RegisterController < ApplicationController

  skip_before_action :set_locale
  skip_before_action :authenticate_login

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to login_url, :notice => t(:register_user_sccess)
    else
      render :action => 'new'
    end

  end

  def destroy
    current_user.forget_me
    cookies.delete :auth_token
    reset_session
    session[:user_id] = nil
    redirect_to new_session_url
  end

  private


    def user_params
      params.require(:user).permit(:phone, :name, :email, :password, :password_confirmation)
    end
end
