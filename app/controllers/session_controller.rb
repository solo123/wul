class AuthController < Devise::SessionsController
  private
  def user_params
    params.require(:user).permit(:username, :login)
  end
end

