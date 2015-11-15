class PasswordResetController < ApplicationController
  before_action :require_valid_token, :only => [:edit, :update]
  skip_before_action :authenticate_login

  def new
  end

  def create
    user = User.find_by_email(params[:email])

    unless user.nil?
      user.refresh_password_reset_token
      UserMailer.password_reset_email(user).deliver_now
    end

    redirect_to new_password_reset_url, :notice => t(:instruction_email_sent, :email => params[:email])
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
    @user = User.find_by_password_reset_token(params[:id])

    if @user.nil? || @user.reset_password_sent_at < Time.now
      redirect_to new_password_reset_url, :alert => t(:reset_url_expired)
    end
  end
end
