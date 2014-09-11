class AuthController < Devise::SessionsController
  require 'net/https'
  require "uri"
  layout "sign_layout" 

  def send_sms(mobile, code)
    url = URI.parse('https://sms-api.luosimao.com/v1/send.json')
    url.user = "api"
    url.password = "key-618b92cc656f8e532bb2c08a0d8d205a"
    req = Net::HTTP::Post.new(url.path)
    data = {'mobile' => mobile, 'cb' => 'callback', 'message' => "感谢您注册沃银网，您的验证码是#{code}【沃银金融】"}
    req.form_data = data
    req.basic_auth url.user, url.password
    con = Net::HTTP.new(url.host, url.port)
    con.use_ssl = true
    res = con.start { |http| http.request(req) }
  end


  def reg
    render :js => "alert('helloworld')"
    #render :js => "window.location.href = '/success'"
  end

  def success
    @suc_msg = @success_message
    @suc_url = @success_url
  end

  def fail

  end

  def checkmobile
    if User.exists?(:mobile => params[:reg_phone])
      render :json => "false" and return
    else
      render :json => "true" and return
    end
  end


  def checkemail
    if User.exists?(:email => params[:reg_email])
      render :json => "false" and return
    else
      render :json => "true" and return
    end
  end

  def useractivate
    if params[:useremail]
      verification = Verification.where(:email => params[:useremail]).first
      if verification
        if params[:token] == verification.email_code
          verification.emailstatus = "confirmed"
          verification.securyscore += 1
          verification.save!
          redirect_to success_path and return
        end
      end
    end
    redirect_to fail_path
  end


  def get_code
    valid = Verification.where(:phone => params[:phone_num]).first
    verify_code = rand(10 ** 6)
    # send_sms(params[:phone_num], verify_code)
    if valid
      render :js => "alert('验证码已经发送,请查收)"
    else
      valid = Verification.new
      render :js => "alert('验证码已经更新,请查收)"
    end
    valid.phone = params[:phone_num]
    valid.phonetime = Time.now
    valid.verify_code = "111111"
    # valid.verify_code = verify_code
    valid.save!
  end

  def create
    if params[:reg_email]
      create_email(params)
    else
      create_mobile(params)
    end
  end

  def create_email(params)
    if User.exists?(:email => params[:reg_email])
      render :js => "alert('邮件地址已经被使用,请用别的邮箱注册')" and return
    end

    @user = User.new
    @user.email = params[:reg_email]
    @user.password = @user.password_confirmation = params[:reg_email_pass]
    if @user.save!
      verify = Verification.new
      verify.email = params[:reg_email]
      verify.emailstatus = "confirming"
      verify.email_code = "111112"
      @user.user_info.verification = verify
      verify.save!
    end
    Reg.regist_confirm(@user.email, verify.email_code).deliver
    render "success"
  end

  def create_mobile(params)
    valid = true
    #if valid = Verification.where(:phone => params[:reg_phone]).first
    if valid
      #if User.exists?(:mobile => valid.phone)
       # render :js => "alert('电话号码已经存在,请用别的号码注册')" and return
       #end

      #if valid.verify_code == params[:reg_code]
      if params[:reg_code] == "111111"
        u = User.new
        #u.mobile = valid.phone
        u.mobile = params[:reg_phone]
        u.password = u.password_confirmation = params[:reg_password]
        u.save!
        #valid.phonetime = Time.now
        #valid.phonestatus = "verified"
        #valid.securyscore += 1
        #u.user_info.verification = valid
        #valid.save!
        render "success" and return
        #render :js => "alert('验证通过')" and return
      end
    else
      render :js => "alert('验证没有通过')" and return
    end
    render :js => "alert('验证码无效,请重新申请')" and return
  end

end

