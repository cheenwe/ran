class QueriesController < ApplicationController
  before_action :set_query, only: [:show, :edit, :update, :destroy]

  # GET /queries
  def index
    @queries = Query.all
  end

  # GET /queries/1
  def show
  end

  # GET /queries/new
  def new
    @query = Query.new
    # @query.records.build
  end

  # GET /queries/1/edit
  def edit
  end

  # POST /queries
  def create
    @query = Query.new(query_params)

    @query.build_from_params

    if @query.save
      redirect_to @query, notice: 'Query was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /queries/1
  def update
    if @query.update(query_params)
      redirect_to @query, notice: 'Query was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /queries/1
  def destroy
    @query.destroy
    redirect_to queries_url, notice: 'Query was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_query
      @query = Query.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def query_params
      params.require(:query).permit(:name, :filters, :user_id, :type, :open)
    end
end
