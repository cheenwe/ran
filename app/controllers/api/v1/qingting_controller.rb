class Api::V1::QingtingController < ApplicationController

  # before_action :set_user, only: [:show, :edit, :update, :destroy]
  # GET /api/v1/users
  def index
    @categories = QingtingApi.categories["data"]
    @api_categories = System.new.categories["categories"]
  end

  # GET /api/v1/users
  def show
    if params[:query]
      @lists = QingtingApi.search("#{params[:query]}")["data"].first["doclist"]["docs"] rescue [""]
    else
      # @category = QingtingApi.get("categories/#{params[:id]}")
      current_page= params[:page]||1
      @lists = QingtingApi.get("categories/#{params[:id]}/channels/order/0/curpage/#{current_page}/pagesize/30")["data"]
      # get("categories/2143/channels/order/0/curpage/1/pagesize/30")


      @api_lists = System.new.channels(params[:id],1,100)["fmchannels"]

    end
  end

  def create

  end

  def new
    if params[:channel_id]

      if params[:action_type] == "create"
        if info = System.new.addchannels(params["channel_id"])
          redirect_to :back,  notice: info
        else
          redirect_to :back,  notice: t("other_error")
        end
      elsif  params[:action_type] == "remove"
        if info = System.new.deletechannels(params[:channel_id])
          redirect_to :back,  notice: info
        else
          redirect_to :back,  notice: t("other_error")
        end
      else
        redirect_to :back,  notice: t("other_error")
      end


    else
      if params[:action_type] == "create"
        if info = System.new.addcategories(1,params["id"],params["name"],params["sequence"],params["section_id"],params["type"])
          redirect_to :back,  notice: info
        else
          redirect_to :back,  notice: t("other_error")
        end
      elsif  params[:action_type] == "remove"
        if info = System.new.deletecategories(params[:category_id])
          redirect_to :back,  notice: info
        else
          redirect_to :back,  notice: t("other_error")
        end
      else
        redirect_to :back,  notice: t("other_error")
      end

    end


  end

end
