class InvestsController < ApplicationController
  before_action :set_invest, only: [:show, :edit, :update, :destroy]

  # GET /invests
  # GET /invests.json
  def index
    @invests = Invest.all
  end

  def buy
    if !current_user
      redirect_to new_user_session_path and return
    end

    if !simple_captcha_valid?
      flash[:notice] = "验证码不正确"
      redirect_to invest_path(params[:invest_id]) and return
    end
    invest = Invest.find(params[:invest_id])
    if invest.onsale
      buyer_balance = current_user.user_info.account.balance
      seller_balance = invest.user_info.account.balance
      if buyer_balance >= invest.resell_price
        current_user.user_info.account.balance -= invest.resell_price
        current_user.save!
        Transaction.createTransaction("buy", invest.resell_price, buyer_balance + invest.resell_price, buyer_balance, current_user.user_info.id, invest.product.deposit_number, invest.invest_type)
        invest.user_info.account.balance += invest.resell_price
        invest.user_info.save!
        Transaction.createTransaction("sell", invest.resell_price, seller_balance, seller_balance + invest.resell_price, invest.user_info.id, invest.product.deposit_number,invest.invest_type)
        # invest.resell_price = 0
        # invest.discount_rate = 0
        invest.onsale = false
        current_user.user_info.invests << invest
        invest.save!
      else
        flash[:notice] = "账户余额或产品可投资余额不足"
      end
      redirect_to invest_path(params[:invest_id]) and return
    end
  end


  def onsale
    pages=10
    @invests = Invest.where(:onsale => true).paginate(:page => params[:page], :per_page => pages)
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
