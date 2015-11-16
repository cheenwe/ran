class PasswordResetController < ApplicationController
  before_action :require_valid_token, :only => [:edit, :update]
  skip_before_action :authenticate_login

  def new
    @user = User.new
  end

  def create
    user = User.find_by_email(user_params[:email])

    unless user.nil?
      user.refresh_reset_password_token
      UserMailer.password_reset_email(user).deliver_now
    end

    redirect_to new_password_reset_url, :notice => t(:instruction_email_sent, :email => user_params[:email])
  end

  # Note: @user is set in require_valid_token
  def edit
  end

  # Note: @user is set in require_valid_token
  def update
    if @user.update_attributes(permitted_params.user.merge({ :password_required => true }))
      redirect_to new_session_url, :notice => t(:password_reset_successfully)
    else
      render :action => 'edit'
    end
  end

  private

  def require_valid_token
    @user = User.find_by_reset_password_token(params[:id])

    # if @user.nil? || @user.reset_password_sent_at < Time.now
    #   redirect_to new_password_reset_url, :alert => t(:reset_url_expired)
    # end
  end

  def user_params
  puts ">>>>>>>>>>>>>>>>#{params}"
    params.require(:user).permit(:id, :name, :phone, :email,:password, :password_confirmation)
  end
end
