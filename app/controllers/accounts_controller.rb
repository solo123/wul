class AccountsController < ApplicationController
	#before_filter :authenticate_user!
  before_action :set_account, only: [:show, :edit, :update, :destroy]
	def password_update
  	user = current_user
		if user.valid_password? params[:old_password]
			if params[:password] == params[:password_confirmation]
		    user.password = user.password_confirmation = params[:password]
				if user.save
		      flash[:notice] = 'Password changed!'
					redirect_to new_user_session_path
					return
				else
		      flash[:error] = user.errors.messages.to_s
				end
			else
				flash[:error] = 'password not match!'
			end
		else
			flash[:error] = 'wrong old password!'
		end
		redirect_to action: :password
	end

	def realname
		@user_info = current_user.user_info
  end

  # GET /accounts
  # GET /accounts.json
  def index
    @accounts = Account.all
  end

  # GET /accounts/1
  # GET /accounts/1.json
  def show
  end

  # GET /accounts/new
  def new
    @account = Account.new
  end

  # GET /accounts/1/edit
  def edit
  end

  # POST /accounts
  # POST /accounts.json
  def create
    @account = Account.new(account_params)

    respond_to do |format|
      if @account.save
        format.html { redirect_to @account, notice: 'Account was successfully created.' }
        format.json { render :show, status: :created, location: @account }
      else
        format.html { render :new }
        format.json { render json: @account.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /accounts/1
  # PATCH/PUT /accounts/1.json
  def update
    respond_to do |format|
      if @account.update(account_params)
        format.html { redirect_to @account, notice: 'Account was successfully updated.' }
        format.json { render :show, status: :ok, location: @account }
      else
        format.html { render :edit }
        format.json { render json: @account.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /accounts/1
  # DELETE /accounts/1.json
  def destroy
    @account.destroy
    respond_to do |format|
      format.html { redirect_to accounts_url }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_account
    @account = Account.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def account_params
    params.require(:account).permit(:user_id, :useable_balance, :balance, :frozen_balance, :total_estate)
  end

end

