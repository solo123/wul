class MonthDepositsController < ResourcesController
  def index
    @month_deposits = MonthDeposit.where(:display => "show")
    if current_user
       @invests = current_user.user_info.invests
       @orders = current_user.orders
    end
  end
end

