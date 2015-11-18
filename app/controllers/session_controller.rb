class SessionController < ApplicationController
	skip_before_action :authenticate_login
	before_filter :check_login_failures_times, only: %w(create)

	def new
		@user = User.new
	end

	def create
		@user = User.new.authenticate(user_params[:name], user_params[:password])
		redirect_after_authentication
	end

	def destroy
		current_user.refresh_remember_token
		cookies.delete :auth_token
		reset_session
		session[:user_id] = nil
		redirect_to new_session_url
	end

	def check_login_failures_times
		return if LoginFailure.matching(request).count <= Setting.max_login_failure_attempts.to_i
		redirect_to new_session_url, :alert => t("session.max_login_attempts")
		false
	end

	def login_success
		if user_params[:remember] == 'true'
			@user.refresh_remember_token
			cookies[:auth_token] = { :value => @user.remember_token, :expires => 2.weeks.from_now }
		end
		session[:user_id] = @user.id
		redirect_url = session.delete(:return_to) || users_url
		redirect_to redirect_url, :only_path => true, :notice => t("session.login_success")
	end

	def login_auth_fail
		if (user = find_user_by_name) && !user.has_password?
			redirect_to new_session_url, :alert => t("user.user_not_find")
		else
			LoginFailure.create(name: user_params[:name], ip: request.remote_ip, user_agent: request.user_agent.to_s.downcase)
			redirect_to new_session_url, :alert => t("session.password_not_match")
		end
	end


	def login_not_found

		if !find_user_by_name
			redirect_to new_session_url, :alert => t("user.user_not_find")
		else
			LoginFailure.create(name: user_params[:name], ip: request.remote_ip, user_agent: request.user_agent.to_s.downcase)
			redirect_to new_session_url, :alert => t("session.name_not_find")
		end
	end


	def find_user_by_name
		user = (User.find_by_name(user_params[:name])  ||  User.find_by_email(user_params[:name])  || User.find_by_phone(user_params[:name]) )
	end

	def redirect_after_authentication
		if @user && !@user.can_login_in?
			redirect_to new_session_url, :alert => t("session.not_activated_yet")
		elsif @user
			login_success
		elsif @user == false
			login_auth_fail
		else
			login_not_found
		end
	end

	def user_params
		params.require(:user).permit(:name, :password)
	end

end
