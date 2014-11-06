class PasswdsController < Devise::PasswordsController
    layout "sign_layout"
  def new

  end

  def username
    if simple_captcha_valid?
    else
      flash[:notice] = "验证码不正确"
      redirect_to usercenter_path
    end
  end


  def verify_method

  end

end
  

