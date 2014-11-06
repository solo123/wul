class PasswdsController < Devise::PasswordsController
  layout "sign_layout"

  def new

  end

  def verify_username
    if !simple_captcha_valid?
      flash[:notice] = "验证码不正确"
      redirect_to username_path and return
    end
    if params[:username] == ""
      flash[:notice] = "用户名不能为空"
      redirect_to username_path and return
    else
      user = User.find_by username: params[:username]
      if user
        @username = user.username
        render "verify_method" and return
      else
        flash[:notice] = "用户名不存在"
      end
      redirect_to username_path and return
    end
  end

  def sendemail
      user = User.find_by username: params[:username]
      if user
        @email_server = @email = user.email
        @email_server[0,@email_server.index('@')+1]="mail."
        render "reset_email_success" and return
      end
      render "verify_method"
  end


  def recover_username
    # if !simple_captcha_valid?
    #   flash[:notice] = "验证码不正确"
    #   redirect_to username_path
    # end
    # else
    #   flash[:notice] = "验证码不正确"
    #   redirect_to usercenter_path
    # end
  end


  def verify_method

  end

end
  

