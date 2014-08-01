class AnalyzersController < ApplicationController
  before_action :set_analyzer, only: [:show, :edit, :update, :destroy]

  # GET /analyzers
  # GET /analyzers.json
  def index
    @analyzers = Analyzer.all
  end

  # GET /analyzers/1
  # GET /analyzers/1.json
  def show
  end

  # GET /analyzers/new
  def new
    @analyzer = Analyzer.new
  end

  # GET /analyzers/1/edit
  def edit
  end

  # POST /analyzers
  # POST /analyzers.json
  def create
    @analyzer = Analyzer.new(analyzer_params)

    respond_to do |format|
      if @analyzer.save
        format.html { redirect_to @analyzer, notice: 'Analyzer was successfully created.' }
        format.json { render :show, status: :created, location: @analyzer }
      else
        format.html { render :new }
        format.json { render json: @analyzer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /analyzers/1
  # PATCH/PUT /analyzers/1.json
  def update
    respond_to do |format|
      if @analyzer.update(analyzer_params)
        format.html { redirect_to @analyzer, notice: 'Analyzer was successfully updated.' }
        format.json { render :show, status: :ok, location: @analyzer }
      else
        format.html { render :edit }
        format.json { render json: @analyzer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /analyzers/1
  # DELETE /analyzers/1.json
  def destroy
    @analyzer.destroy
    respond_to do |format|
      format.html { redirect_to analyzers_url, notice: 'Analyzer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_analyzer
      @analyzer = Analyzer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def analyzer_params
      params.require(:analyzer).permit(:product, :owner_num, :invest_num)
    end
end
