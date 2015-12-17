class Api::V1::Qingting::ProgramsController < ApplicationController
  before_action :set_api_v1_qingting_program, only: [:show, :edit, :update, :destroy]

  # GET /api/v1/qingting/programs
  def index

    if params[:query]
      @api_v1_qingting_programs = QingtingApi.search("#{params[:query]}","program_ondemand")["data"].last["doclist"]["docs"] rescue [""]
    elsif params[:channel_id]
      page_size = params[:page_size]  rescue 30
      page = params[:page]  rescue 1
      @api_v1_qingting_programs = QingtingApi.ondemand_channel(params[:channel_id], page, page_size)["data"]  rescue [""]
    else
      @api_v1_qingting_programs = [""]
    end
  end


  # GET /api/v1/qingting/programs
  def search

    if params[:channel_id]
      page_size = params[:page_size]  rescue 30
      @api_v1_qingting_programs = QingtingApi.ondemand_channel(params[:channel_id],1,page_size)
    else

    end
  end
  # GET /api/v1/qingting/programs/1
  def show
  end

  # GET /api/v1/qingting/programs/new
  def new
    @api_v1_qingting_program = Api::V1::Qingting::Program.new
  end

  # GET /api/v1/qingting/programs/1/edit
  def edit
  end

  # POST /api/v1/qingting/programs
  def create
    @api_v1_qingting_program = Api::V1::Qingting::Program.new(api_v1_qingting_program_params)

    if @api_v1_qingting_program.save
      redirect_to @api_v1_qingting_program, notice: 'Program was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /api/v1/qingting/programs/1
  def update
    if @api_v1_qingting_program.update(api_v1_qingting_program_params)
      redirect_to @api_v1_qingting_program, notice: 'Program was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /api/v1/qingting/programs/1
  def destroy
    @api_v1_qingting_program.destroy
    redirect_to api_v1_qingting_programs_url, notice: 'Program was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_api_v1_qingting_program
      @api_v1_qingting_program = Api::V1::Qingting::Program.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def api_v1_qingting_program_params
      params.require(:api_v1_qingting_program).permit(:name)
    end
end
