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
    @object = Product.friendly.find(params[:id])
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
    op = AccountOperation.new(:op_name => "invest", :op_action => "join", :op_amount => amount, :operator => "system",:uinfo_id => user.user_info.id,
                              :op_resouce_name => product.deposit_number, :op_resource_id => product.id)
    op.execute_transaction
  end

  def join
    @product = Product.friendly.find(params[:id])
    limit = 100000
    amount = params[:product_value].to_i
    balance = current_user.user_info.account.balance
    invests = current_user.user_info.invests

    if simple_captcha_valid?
    else
      flash[:notice] = "验证码不正确"
      redirect_to product_detail_path(@product.product_type, @product.id) and return
    end


    if amount < @product.min_limit
      flash[:notice] = "本产品最小购买额度为#{@product.min_limit}元"
      redirect_to product_detail_path(@product.product_type, @product.id) and return
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
    flash[:success] = "加入正在审核, 请稍后查看"
    redirect_to product_detail_path(@product.product_type,@product.id) and return
  end
end

