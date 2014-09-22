module Usercenter
  class ConsoleController< ApplicationController
    layout "usercenter"

    before_filter :authenticate_user!, :set_cache_buster
    before_action :confirm_status, only: [:resell]

    def index

    end

    def overview
      @deposit = current_user.user_info.account
    end

    def history
      pages = 10
      @transactions = current_user.user_info.transactions
      @transactions = case params[:filter]
                        when 'all'
                          @transactions
                        else
                          @transactions.where(:trans_type => params[:filter])
                      end
      @transactions = case params[:date_range]
                        when 'all'
                          @transactions
                        when 'week'
                          @transactions.where("created_at >= ?", 1.week.ago)
                        when 'month'
                          @transactions.where("created_at >= ?", 1.month.ago)
                        when 'month2'
                          @transactions.where("created_at >= ?", 2.months.ago)
                        when 'month3'
                          @transactions.where("created_at >= ?", 3.months.ago)
                        else
                          @transactions
                      end

      @transactions = @transactions.paginate(:page => params[:page], :per_page => pages)
    end

    def charge

    end

    def assets_analyzer
      @analyzer = current_user.user_info.analyzer
    end

    def redemption
      pages = 10
      @fixed_deposits = current_user.user_info.invests.where(:invest_type => 'fixed',:onsale => false).paginate(:page => params[:page], :per_page => pages)
      @month_deposits = current_user.user_info.invests.where(:invest_type => 'month',:onsale => false).paginate(:page => params[:page], :per_page => pages)
    end

    def agreements
      pages = 10
      @fixed_deposits = current_user.user_info.invests.where(:invest_type => 'fixed',:onsale => false).paginate(:page => params[:page], :per_page => pages)
      @month_deposits = current_user.user_info.invests.where(:invest_type => 'month',:onsale => false).paginate(:page => params[:page], :per_page => pages)
    end

    def autoinvest
      @delagator = current_user.user_info.delagator
    end

    def invest_detail

    end


    def setup_autoinvest
      @delagator = current_user.user_info.delagator
      delagator_params = params[:delagator]
      if delagator_params[:status] == "1"
        @delagator.status = 0
      else
        @delagator.status = 1
        @delagator.each_invest_amount = delagator_params[:each_invest_amount]
        @delagator.min_invest_amount = delagator_params[:min_invest_amount]
        @delagator.max_invest_period = delagator_params[:max_invest_period]
        @delagator.min_remain_balance = delagator_params[:min_remain_balance]
        @delagator.last_open_time = Time.now
      end
        @delagator.save!
        redirect_to usercenter_console_autoinvest_path
    end


    def confirm_status
      if current_user.user_info.verification.phone_confirm_status
      end
    end

    def show_agreement
        product = Invest.find(params[:id]).product
        @agreement = product.agreement
    end

    def resell
      invest = Invest.find(params[:format])
      rate = params[:discount_rate].to_f
      invest.resell(rate)
      redirect_to usercenter_console_redemption_path
    end

    def invest_history
      @fixed_deposits = current_user.user_info.invests.where(:invest_type => 'fixed',:onsale => false)
      @month_deposits = current_user.user_info.invests.where(:invest_type => 'month',:onsale => false)
    end

    # def charge_mock
    #   if current_user
    #     charge_val = params[:charge_value].to_i
    #     # balance = current_user.user_info.account.balance
    #     account = current_user.user_info.account
    #     account.send_account("charge", "account" )
    #
    #     Transaction.createTransaction("charge", charge_val, balance, balance + charge_val, current_user.user_info.id, "充值","charge")
    #     current_user.user_info.account.balance += charge_val
    #     current_user.user_info.save!
    #   end
    #   render usercenter_console_charge_bank_path
    # end

    def charge_mock
      if current_user
        charge_val = params[:charge_value].to_i
        op = AccountOperation.new(:op_name => "account", :op_action => "charge", :op_amount => charge_val, :operator => "system",:uinfo_id => current_user.user_info.id )
        op.execute_transaction
        # current_user.user_info.account.balance += charge_val
        # current_user.user_info.save!
      end
      render usercenter_console_charge_bank_path
    end

    def open_auto_invest
       delagator = current_user.user_info.delagator
       delagator.status = 1
       delagator.save!
       render :js => "alert(#{u})"
    end

    def bankcard
      @bankcards = current_user.bankcards
    end

    def coupon
      @coupons = current_user.coupons
    end


    def create_order
      @product = FixedDeposit.find(params[:format])
    end

    def join
      @product = FixedDeposit.find(params[:format])
      invest = Invest.new
      invest.loan_number = @product.deposit_number
      invest.amount = params[:product_value].to_i

      invests = current_user.user_info.invests
      current_amount = 0
      invests.each{|inv| current_amount += inv.amount if inv.loan_number == @product.deposit_number}
      if current_amount + invest.amount > 100000
          flash[:notice] = "已经超过本产品购买额度"
          redirect_to fixed_deposit_path(params[:format]) and return
      end


      if current_user.user_info.account.balance >= invest.amount and @product.free_invest_amount >= invest.amount
         @product.free_invest_amount -= invest.amount
         current_user.user_info.account.balance -= invest.amount
         current_user.save!
         @product.save!
         invest.create_transaction(current_user.user_info.account)
         current_user.user_info.invests << invest
         invest.save!
      else
        flash[:notice] = "账户余额或产品可投资余额不足"
      end
      redirect_to fixed_deposit_path(params[:format]) and return
    end

    def save_order
      if params[:product_value].to_i > (current_user.user_info.account.balance - current_user.user_info.account.frozen_balance)
          render "shared/balance_error" and return
      end
      order = Order.new
      order.product_type = params[:product_type]
      order.product_id = params[:product_id]
      order.product_value = params[:product_value].to_i
      current_user.orders << order
      current_user.user_info.account.frozen_balance += order.product_value
      current_user.save!
      order.create_transaction(current_user.user_info.account)
      order.save!
      redirect_to usercenter_console_history_path
    end

    def set_cache_buster
      response.headers["Cache-Control"] = "no-cache, no-store, max-age=0, must-revalidate"
      response.headers["Pragma"] = "no-cache"
      response.headers["Expires"] = "Fri, 01 Jan 1990 00:00:00 GMT"
    end

  end
end