class Usercenter::CouponsController < ApplicationController
  before_action :set_usercenter_coupon, only: [:show, :edit, :update, :destroy]

  # GET /usercenter/coupons
  # GET /usercenter/coupons.json
  def index
    @usercenter_coupons = Usercenter::Coupon.all
  end

  # GET /usercenter/coupons/1
  # GET /usercenter/coupons/1.json
  def show
  end

  # GET /usercenter/coupons/new
  def new
    @usercenter_coupon = Usercenter::Coupon.new
  end

  # GET /usercenter/coupons/1/edit
  def edit
  end

  # POST /usercenter/coupons
  # POST /usercenter/coupons.json
  def create
    @usercenter_coupon = Usercenter::Coupon.new(usercenter_coupon_params)

    respond_to do |format|
      if @usercenter_coupon.save
        format.html { redirect_to @usercenter_coupon, notice: 'Coupon was successfully created.' }
        format.json { render :show, status: :created, location: @usercenter_coupon }
      else
        format.html { render :new }
        format.json { render json: @usercenter_coupon.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /usercenter/coupons/1
  # PATCH/PUT /usercenter/coupons/1.json
  def update
    respond_to do |format|
      if @usercenter_coupon.update(usercenter_coupon_params)
        format.html { redirect_to @usercenter_coupon, notice: 'Coupon was successfully updated.' }
        format.json { render :show, status: :ok, location: @usercenter_coupon }
      else
        format.html { render :edit }
        format.json { render json: @usercenter_coupon.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /usercenter/coupons/1
  # DELETE /usercenter/coupons/1.json
  def destroy
    @usercenter_coupon.destroy
    respond_to do |format|
      format.html { redirect_to usercenter_coupons_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_usercenter_coupon
      @usercenter_coupon = Usercenter::Coupon.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def usercenter_coupon_params
      params.require(:usercenter_coupon).permit(:userid, :amount, :title, :description)
    end
end
