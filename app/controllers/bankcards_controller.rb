class BankcardsController < ApplicationController
  before_action :set_bankcard, only: [:show, :edit, :update, :destroy]

  # GET /bankcards
  # GET /bankcards.json
  def index
    @bankcards = Bankcard.all
  end

  # GET /bankcards/1
  # GET /bankcards/1.json
  def show
  end

  # GET /bankcards/new
  def new
    @bankcard = Bankcard.new
  end

  # GET /bankcards/1/edit
  def edit
  end

  # POST /bankcards
  # POST /bankcards.json
  def create
    @bankcard = Bankcard.new(bankcard_params)

    respond_to do |format|
      if @bankcard.save
        format.html { redirect_to @bankcard, notice: 'Bankcard was successfully created.' }
        format.json { render :show, status: :created, location: @bankcard }
      else
        format.html { render :new }
        format.json { render json: @bankcard.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bankcards/1
  # PATCH/PUT /bankcards/1.json
  def update
    respond_to do |format|
      if @bankcard.update(bankcard_params)
        format.html { redirect_to @bankcard, notice: 'Bankcard was successfully updated.' }
        format.json { render :show, status: :ok, location: @bankcard }
      else
        format.html { render :edit }
        format.json { render json: @bankcard.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bankcards/1
  # DELETE /bankcards/1.json
  def destroy
    @bankcard.destroy
    respond_to do |format|
      format.html { redirect_to bankcards_url, notice: 'Bankcard was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bankcard
      @bankcard = Bankcard.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def bankcard_params
      params.require(:bankcard).permit(:user_id, :bankname, :cardid)
    end
end
