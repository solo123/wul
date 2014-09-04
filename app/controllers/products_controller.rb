class ProductsController < ResourcesController
  def index
    pages=10
    @collection = Product.where(:display => "show", :product_type => params[:product_type]).paginate(:page => params[:page], :per_page => pages)
    render "products/"+params[:product_type]
    #if current_user
       #@invests = current_user.user_info.invests
       #@orders = current_user.orders
    #end
  end

  def detail
    @object = Product.find(params[:id])
    render "products/show"
  end


  def fixed_deposits
    pages=10
    @fixed_deposits = Product.where(:display => "show", :product_type => "fixed").paginate(:page => params[:page], :per_page => pages)
  end

  def over_limit?(amount, invests, limit, product_id)
    current_amount = 0
    invests.each{|inv| current_amount += inv.amount if inv.product_id == product_id}
    return current_amount + amount > limit
  end
  def over_balance?(balance, amount)
    balance < amount
  end
  def over_product_freeamount?(free_invest_amount, amount)
    free_invest_amount < amount
  end

  def create_invest(amount, product, user)
    product.free_invest_amount -= amount
    product.fixed_invest_amount += amount
    product.owner_num += 1
    product.save!
    invest = Invest.new
    invest.invest_type = product.product_type
    invest.annual_rate = product.annual_rate
    invest.amount = amount
    invest.loan_number = product.deposit_number
    invest.repayment_period = product.repayment_period
    user.user_info.invests << invest
    @product.invests << invest
    user.user_info.account.balance -= amount
    user.save!
    invest.save!
    balance = user.user_info.account.balance
    Transaction.createTransaction("invest", invest.amount, balance + amount, balance, user.user_info.id,  @product.deposit_number)
  end

  def join
    @product = Product.find(params[:id])
    limit = 100000
    amount = params[:product_value].to_i
    balance = current_user.user_info.account.balance
    invests = current_user.user_info.invests

    if amount < 1000
      flash[:notice] = "本产品最小购买额度为1000元"
      redirect_to product_detail_path(@product.product_type,@product.id) and return
    end

    if over_limit?(amount, invests, limit ,@product.id)
      flash[:notice] = "已经超过本产品购买额度"
      redirect_to product_detail_path(@product.product_type,@product.id) and return
    end

    if over_balance?(balance, amount)
      flash[:notice] = "账户余额不足"
      redirect_to product_detail_path(@product.product_type,@product.id) and return
    end

    if over_product_freeamount?(@product.free_invest_amount, amount)
      flash[:notice] = "产品可投资余额不足"
      redirect_to product_detail_path(@product.product_type,@product.id) and return
    end

    create_invest(amount, @product, current_user)
    flash[:success] = "产品购入成功,可在用户中心-投资列表查看"
    redirect_to product_detail_path(@product.product_type,@product.id) and return
  end
end

