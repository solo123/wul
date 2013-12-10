class AccountsController < ApplicationController
	def password_update
		if params[:password] == params[:password_confirmation]
			user = current_user
			user.password = user.password_confirmation = params[:password]
			unless user.save
			  flash[:error] = user.errors.messages.to_s
				redirect_to action: :password
			  return
			end
		end
		render text: 'Password updated!!'
	end
end

