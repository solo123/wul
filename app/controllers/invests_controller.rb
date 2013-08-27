class InvestsController < ApplicationController
  before_action :set_invest, only: [:show, :edit, :update, :destroy]

  # GET /invests
  # GET /invests.json
  def index
    @invests = Invest.all
  end

  # GET /invests/1
  # GET /invests/1.json
  def show
  end

  # GET /invests/new
  def new
    @invest = Invest.new
  end

  # GET /invests/1/edit
  def edit
  end

  # POST /invests
  # POST /invests.json
  def create
    @invest = Invest.new(invest_params)

    respond_to do |format|
      if @invest.save
        format.html { redirect_to @invest, notice: 'Invest was successfully created.' }
        format.json { render action: 'show', status: :created, location: @invest }
      else
        format.html { render action: 'new' }
        format.json { render json: @invest.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /invests/1
  # PATCH/PUT /invests/1.json
  def update
    respond_to do |format|
      if @invest.update(invest_params)
        format.html { redirect_to @invest, notice: 'Invest was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @invest.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /invests/1
  # DELETE /invests/1.json
  def destroy
    @invest.destroy
    respond_to do |format|
      format.html { redirect_to invests_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_invest
      @invest = Invest.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def invest_params
      params.require(:invest).permit(:jkbh, :jybh)
    end
end
