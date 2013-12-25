class AccountsController < ApplicationController
	before_filter :authenticate_user!
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

end

