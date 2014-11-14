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
        verify_enable(user)
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
      @email_server[0, @email_server.index('@')+1]="mail."
      verify_enable(user)
      render "reset_email_success" and return
    end
    render "verify_method"
  end


  def sendsms
    user = User.find_by username: params[:username]

    verify_code = rand(10 ** 6)
    verify = user.user_info.verification
    verify.verify_code = verify_code
    verify.save!
    @mobile = user.mobile
    @verify_code = verify_code
    @username = params[:username]
    render "reset_mobile_success" and return
  end

  def reset_pass
    email= params[:email]
    username = params[:username]
    if email
      user = User.find_by email: email
      verify = user.user_info.verification
      if verify && verify.email_code == params[:token]
        render "reset_pass" and return
      else
        render "fail" and return
      end
    else
      user = User.find_by username: username
      render "reset_pass" and return
    end
  end

  def reset_pass_sms
    mobile= params[:mobile]
    if !mobile.nil?
      user = User.find_by mobile: mobile
      verify = user.user_info.verification
      if verify && verify.verify_code == params[:verify_code]
        render "reset_pass" and return
      else
        render "fail" and return
      end
    else
      render "fail" and return
    end
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

  def verify_enable(user)
    if user.email
      @email = user.email
    end

    if user.mobile
      @mobile = user.mobile
    end

    if user.username
      @username = user.username
    end
  end


  def reset_pass_question
    user = User.find_by username: params[:username]
    @verify = user.user_info.verification
    @verify.question_change = true
    @verify.verify_secret =
    @username= params[:username]
    render "reset_question_success" and return
  end

  def confirm_question
    user = User.find_by username: params[:username]
    @verify = user.user_info.verification
    if params[:answer] == @verify.safe_question_answer
      redirect_to reset_pass_path(:username=>params[:username])
    else
      render "fail" and return
    end

  end


  def reset_password
    password = params[:recover_password]
    if params[:email] != ""
      user = User.find_by email: params[:email]
      if user
        user.password = user.password_confirmation = params[:recover_password]
        user.save!
        render "success"
      else
        render "fail" and return
      end
    elsif params[:mobile] != ""
      user = User.find_by mobile: params[:mobile]
      if user
        user.password = user.password_confirmation = params[:recover_password]
        user.save!
        render "success"
      else
        render "fail" and return
      end

    else
      user = User.find_by username: params[:username]
      if user
        user.password = user.password_confirmation = params[:recover_password]
        user.save!
        render "success"
      else
        render "fail" and return
      end

    end

  end

end
  

