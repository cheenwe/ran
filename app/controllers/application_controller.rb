class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :authenticate_login

  before_action :set_locale

  def set_locale
    I18n.locale = user_locale

    # after store current locale
    cookies[:locale] = params[:locale] if params[:locale]
  rescue I18n::InvalidLocale
    I18n.locale = I18n.default_locale
  end


  helper_method :clipboard, :current_user, :signed_in?, :permitted_params

  def current_user
    @current_user ||= User.find_by_id(session[:user_id])
  end

  def signed_in?
    !!current_user
  end

  def permitted_params
    @permitted_params ||= PermittedParams.new(params, current_user)
  end

  def authenticate_login
    if current_user.nil?
      user = User.find_by_remember_token(cookies[:auth_token]) unless cookies[:auth_token].blank?

      if user.nil?
        reset_session
        session[:user_id] = nil
        session[:return_to] = request.fullpath

        redirect_to new_session_url
      else
        user.refresh_remember_token
        session[:user_id] = user.id
        cookies[:auth_token] = user.remember_token
      end
    end
  end

  def redirect_back_or_default(default)
    redirect_to(session[:return_to] || default)
    session[:return_to] = nil
  end


  private

    def user_locale
      params[:locale] || cookies[:locale] || http_head_locale || I18n.default_locale
    end

    def http_head_locale
      http_accept_language.language_region_compatible_from(I18n.available_locales)
    end
end
