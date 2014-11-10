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

      verify_code = rand(10 ** 6)
      verify = user.user_info.verification
      verify.email_code = verify_code
      verify.save!

          # Verification.create_with(emailstatus: "confirming", email_code: verify_code).find_or_create_by(email: params[:reg_email])
      # verify.passwd = params[:reg_email_pass]
      # verify.save!
      EmailWorker.perform_async(verify.email, verify.email_code, "recover")
      # @message = "一封验证邮件已经发送到您注册的邮箱内，请查收并验证邮箱,验证后登录"
      # render "success"


      if user
        @email_server = @email = user.email
        @email_server[0,@email_server.index('@')+1]="mail."
        render "reset_email_success" and return
      end
      render "verify_method"
  end


  def reset_pass

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


  def reset_password
       flash[:notice] = "密码长度不够"
       redirect_to reset_pass_path
  end

end
  

