class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  swagger_controller :users, "UsersController"

     swagger_api :index do
      summary "test"
      response :unauthorized
      response :not_acceptable
     end


  # GET /api/v1/users
  def index
    render :json =>   {:seq_no => params[:seq_no],  :headcode =>200, :result =>"Success", :users => User.all}, :status => 200
  end

  # GET /api/v1/users/1
  def show
  end

  # GET /api/v1/users/new
  def new
    @user = User.new
  end

  # GET /api/v1/users/1/edit
  def edit
  end

  # POST /api/v1/users
  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to @user, notice: 'User was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /api/v1/users/1
  def update
    if @user.update(user_params)
      redirect_to @user, notice: 'User was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /api/v1/users/1
  def destroy
    @user.destroy
    redirect_to users_url, notice: 'User was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def user_params
      params.require(:user).permit(:name, :phone, :email, :password_salt, :encrypted_password, :remember_token, :reset_password_token, :reset_password_sent_at, :register_token, :register_token_sent_at, :sign_in_count)
    end
end
