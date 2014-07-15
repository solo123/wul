class Usercenter::BankcardsController < ApplicationController
  before_action :set_usercenter_bankcard, only: [:show, :edit, :update, :destroy]
  layout "usercenter"
  # GET /usercenter/bankcards
  # GET /usercenter/bankcards.json
  def index
    @usercenter_bankcards = Usercenter::Bankcard.all
  end

  # GET /usercenter/bankcards/1
  # GET /usercenter/bankcards/1.json
  def show
  end

  # GET /usercenter/bankcards/new
  def new
    @usercenter_bankcard = Usercenter::Bankcard.new
  end

  # GET /usercenter/bankcards/1/edit
  def edit
  end

  # POST /usercenter/bankcards
  # POST /usercenter/bankcards.json
  def create
    @usercenter_bankcard = Usercenter::Bankcard.new(usercenter_bankcard_params)

    respond_to do |format|
      if @usercenter_bankcard.save
        format.html { redirect_to @usercenter_bankcard, notice: 'Bankcard was successfully created.' }
        format.json { render :show, status: :created, location: @usercenter_bankcard }
      else
        format.html { render :new }
        format.json { render json: @usercenter_bankcard.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /usercenter/bankcards/1
  # PATCH/PUT /usercenter/bankcards/1.json
  def update
    respond_to do |format|
      if @usercenter_bankcard.update(usercenter_bankcard_params)
        format.html { redirect_to @usercenter_bankcard, notice: 'Bankcard was successfully updated.' }
        format.json { render :show, status: :ok, location: @usercenter_bankcard }
      else
        format.html { render :edit }
        format.json { render json: @usercenter_bankcard.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /usercenter/bankcards/1
  # DELETE /usercenter/bankcards/1.json
  def destroy
    @usercenter_bankcard.destroy
    respond_to do |format|
      format.html { redirect_to usercenter_bankcards_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_usercenter_bankcard
      @usercenter_bankcard = Usercenter::Bankcard.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def usercenter_bankcard_params
      params.require(:usercenter_bankcard).permit(:bankname, :cardid, :user_id)
    end
end
