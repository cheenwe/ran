class Api::V1::UsersController < ApplicationController
  before_action :set_api_v1_user, only: [:show, :edit, :update, :destroy]

  # GET /api/v1/users
  def index
    @api_v1_users = Api::V1::User.all
  end

  # GET /api/v1/users/1
  def show
  end

  # GET /api/v1/users/new
  def new
    @api_v1_user = Api::V1::User.new
  end

  # GET /api/v1/users/1/edit
  def edit
  end

  # POST /api/v1/users
  def create
    @api_v1_user = Api::V1::User.new(api_v1_user_params)

    if @api_v1_user.save
      redirect_to @api_v1_user, notice: 'User was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /api/v1/users/1
  def update
    if @api_v1_user.update(api_v1_user_params)
      redirect_to @api_v1_user, notice: 'User was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /api/v1/users/1
  def destroy
    @api_v1_user.destroy
    redirect_to api_v1_users_url, notice: 'User was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_api_v1_user
      @api_v1_user = Api::V1::User.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def api_v1_user_params
      params.require(:api_v1_user).permit(:name, :phone, :email, :passwd_salt, :encrypted_password, :remember_token, :reset_password_token, :reset_password_sent_at, :register_token, :register_token_sent_at, :sign_in_count)
    end
end
