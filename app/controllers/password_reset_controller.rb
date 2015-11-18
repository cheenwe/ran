class PasswordResetController < ApplicationController
  before_action :require_valid_token, :only => [:edit, :update]
  skip_before_action :authenticate_login

  def new
    @user = User.new
  end

  def create
    @user = User.find_by_email(user_params[:email])

    if @user.nil?
      redirect_to(new_password_reset_url, alert: t("user.user_not_find"))
    else
      @user.refresh_reset_password_token
      UserMailer.password_reset_email(@user).deliver_now
      redirect_to login_url, :notice => "#{t('password_reset.instruction_email_sent', email: user_params[:email])}"
    end

  end

  # Note: @user is set in require_valid_token
  def edit
  end

  # Note: @user is set in require_valid_token
  def update
    if user_params[:password] !=user_params[:password_confirmation]
      redirect_to edit_password_reset_url(params[:id]), :alert=> t("password_reset.password_not_same")
    else
      if @user.update_attributes(user_params)
        redirect_to new_session_url, :notice => t("password_reset.password_reset_successfully")
      else
      redirect_to edit_password_reset_url(params[:id]), :alert=> t("other_error")
      end
    end
  end

  private

  def require_valid_token
    @user = User.find_by_reset_password_token(params[:id])
    if @user.nil?
      redirect_to new_password_reset_url, :alert =>t("password_reset.user_not_find")
    elsif (@user.reset_password_sent_at + Setting.mail_token_expire_hour.hour) < Time.now
      redirect_to new_password_reset_url, :alert => t("password_reset.reset_url_expired")
    else
      #redirect_to new_password_reset_url, :alert => t("other_error")
    end
  end

  def user_params
    params.require(:user).permit(:id, :name, :phone, :email,:password, :password_confirmation)
  end
end
