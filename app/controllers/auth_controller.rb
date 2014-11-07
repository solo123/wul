class AuthController < Devise::SessionsController
  require 'net/https'
  require 'json'
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
          verification.emailstatus = "verified"
          verification.securyscore += 1
          user = User.new
          user.email = params[:useremail]
          user.password = user.password_confirmation = verification.passwd
          user.save!
          user.user_info.verification = verification
          verification.save!
          @message = "用户邮件激活成功"
          render "success" and return
        else
          @message = "激活码错误,激活失败"
          render "fail" and return
        end
      end
    end
    @message = "激活失败, 用户不存在"
    render "fail"
  end


  def get_code
    valid = Verification.where(:phone => params[:phone_num]).first
    if User.exists?(:mobile => params[:phone_num])
      render :js => "alert('该手机号码已经被注册)" and return
    end
    verify_code = rand(10 ** 6)

    # send_sms(params[:phone_num], verify_code)
    if valid
      if valid.phonestatus == "verified"
        render :js => "alert('该手机号码已经被注册)" and return
      else
        valid.verify_code = verify_code
        valid.save!
        render :js => "alert('该号码的验证码是：#{verify_code}')" and return
      end
    else
      valid = Verification.new
      valid.phone = params[:phone_num]
      valid.verify_code = verify_code
      valid.save!
      render :js => "alert('该号码的验证码是：#{verify_code}')" and return
    end
  end


  def confirm_code
    valid = current_user.user_info.verification
    verify_code = rand(10 ** 6)
    # send_sms(params[:phone_num], verify_code)

    valid.phone = params[:phone_num]
    valid.phonetime = Time.now
    #valid.verify_code = "222222"
    valid.verify_code = verify_code
    valid.save!
    render :js => "alert('验证码是#{verify_code}')" and return
  end


  def test_json
      url ="http://p2p.ips.net.cn/CreditWeb/CreateNewIpsAcct.aspx"
      # data={:argMerCode => '808801'}
      # uri = URI.parse(url)
      # http = Net::HTTP.new(uri.host, uri.port)
      # # http.use_ssl = true
      # request = Net::HTTP::Post.new(uri.path, {'Content-Type' =>'application/json', 'argMerCode' => '808801', 'arg3DesXmlPara' =>'232123', 'argSign' => 'agrg'})
      # # request.body = data.to_json
      # response = http.request(request)
      # # op_res = JSON.parse response.body
      #  logger.info("the errcode is #{response.body}" )


      uri = URI(url)
      res = Net::HTTP.post_form(uri, 'argMerCode' => '808801', 'arg3DesXmlPara' =>'232123', 'argSign' => 'agrg')
      puts res.body




    # op = AccountOperation.new(:op_name => "invest", :op_action => "buy", :operator => "system", :uinfo_id => current_user.user_info.id,
    #                           :op_asset_id => 12, :op_resource_id => 12)
    #
    #
    # op.execute_transaction
   render :json => "OK"
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

    verify_code = rand(10 ** 6)
    verify = Verification.create_with(emailstatus: "confirming", email_code: verify_code).find_or_create_by(email: params[:reg_email])
    verify.passwd = params[:reg_email_pass]
    verify.save!
    EmailWorker.perform_async(verify.email, verify.email_code, "reg")
    @message = "一封验证邮件已经发送到您注册的邮箱内，请查收并验证邮箱,验证后登录"
    render "success"
  end

  def create_mobile(params)
    # valid = true
    valid = Verification.where(:phone => params[:reg_phone]).first
    if valid
      if User.exists?(:mobile => valid.phone)
        render :js => "alert('电话号码已经存在,请用别的号码注册')" and return
      end

      if valid.verify_code == params[:reg_code]
        u = User.new
        u.mobile = valid.phone
        # u.mobile = params[:reg_phone]
        u.password = u.password_confirmation = params[:reg_password]
        u.save!
        valid.phonetime = Time.now
        valid.phonestatus = "verified"
        valid.securyscore += 1
        u.user_info.verification = valid
        u.user_info.mobile = valid.phone
        u.user_info.save!
        valid.save!
        # render "success" and return
        render "success"
      else
        @message = "验证码不正确，请重新验证"
        render "fail"
        #render :js => "alert('验证没有通过')" and return
      end
    else
      @message = "手机验证失败，请重新申请"
      render "fail"
      #render :js => "alert('验证码无效,请重新申请')" and return
    end
  end

end

