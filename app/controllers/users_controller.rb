class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :show, :destroy]

  def index
    @users = User.all
    @q = @users.search(params[:q])
    @users = @q.result(:distinct => true).paginate(:page => params[:page], :per_page => params[:per_page])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = 'User saved.'
      redirect_to users_path
    else
      flash.now[:error] = @user.errors.full_messages.first
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:success] = 'User updated.'
      redirect_to users_path
    else
      flash.now[:error] = @user.errors.full_messages.first
      render :edit
    end
  end

  def destroy
    @user.destroy
    flash[:success] = 'User destroyed.'
    redirect_to users_path
  end

  private
  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :password)
  end

end
