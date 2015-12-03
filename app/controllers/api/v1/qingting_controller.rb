class Api::V1::QingtingController < ApplicationController

  # before_action :set_user, only: [:show, :edit, :update, :destroy]
  # GET /api/v1/users
  def index
    @categories = QingtingApi.categories["data"]
  end

  # GET /api/v1/users
  def show
    # @category = QingtingApi.get("categories/#{params[:id]}")
    current_page= params[:page]||1
    @lists = QingtingApi.get("categories/#{params[:id]}/channels/order/0/curpage/#{current_page}/pagesize/30")
    # get("categories/2143/channels/order/0/curpage/1/pagesize/30")

  end


end
