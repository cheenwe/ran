class RegisterController < ApplicationController

	before_action :require_valid_token, :only => [:edit, :update]
	skip_before_action :authenticate_login

	def new
		@user = User.new
	end

	def create
		if verify_rucaptcha?(@user)
			@user = User.new(user_params)
			if @user.save
				redirect_to login_url, :notice => t('register.register_by_email_success', email: user_params[:email])
				UserMailer.confirmation_email(@user).deliver_now
			else
				redirect_to register_url, :alert => t("register.register_failure")
			end
		else
			redirect_to register_url, :alert => t("register.captcha_code_error")
		end

	end


	def edit
		if @user.verified?
			redirect_to new_session_url, :notice => t("register.register_verified_again")
		else
			@user.update(verified: true)
			redirect_to new_session_url, :notice => t("register.register_verified_successfully")
		end
	end


	private

		def require_valid_token
			@user = User.find_by_register_token(params[:id])

			if @user.nil?
				redirect_to new_password_reset_url, :alert =>t("password_reset.user_not_find")
			elsif (@user.register_token_sent_at + Setting.mail_token_expire_hour.hour) < Time.now
				redirect_to new_password_reset_url, :alert => t("password_reset.reset_url_expired")
			else
				#redirect_to new_password_reset_url, :alert => t("other_error")
			end
		end

		def user_params
			params.require(:user).permit(:phone, :name, :email, :password, :password_confirmation)
		end
end
