class MonthDepositsController < ResourcesController
  def index
    pages=10
    @month_deposits = MonthDeposit.where(:display => "show").paginate(:page => params[:page], :per_page => pages)
  end

  # def join
  #   @product = MonthDeposit.find(params[:month_deposit_id])
  #   invest = Invest.new
  #   invest.loan_number = @product.deposit_number
  #   invest.amount = params[:product_value].to_i
  #   balance = current_user.user_info.account.balance
  #
  #
  #
  #   invests = current_user.user_info.invests
  #   current_amount = 0
  #   invests.each{|inv| current_amount += inv.amount if inv.loan_number == @product.deposit_number}
  #   if current_amount + invest.amount > 100000
  #     flash[:notice] = "已经超过本产品购买额度"
  #     redirect_to month_deposit_path(params[:month_deposit_id]) and return
  #   end
  #
  #   if balance >= invest.amount and @product.free_invest_amount >= invest.amount
  #     Transaction.createTransaction("invest", invest.amount, balance, balance - invest.amount, current_user.user_info.id,  @product.deposit_number)
  #     @product.free_invest_amount -= invest.amount
  #     current_user.user_info.account.balance -= invest.amount
  #     current_user.save!
  #     @product.owner_num += 1
  #     @product.save!
  #     #invest.profit_date = @product.join_date
  #     invest.invest_type = "month"
  #     current_user.user_info.invests << invest
  #     invest.save!
  #   else
  #     flash[:notice] = "账户余额或产品可投资余额不足"
  #   end
  #   redirect_to month_deposit_path(params[:month_deposit_id]) and return
  # end


end

