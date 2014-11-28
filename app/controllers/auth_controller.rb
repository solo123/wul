# coding: utf-8
class AuthController < Devise::SessionsController
  require 'net/https'
  # require 'net/http'
  # require 'json'
  require "uri"
  # require 'openssl'
  layout "sign_layout"

  def send_sms(mobile, code)
    message = "感谢您注册沃银网，您的验证码是#{code}【沃银金融】"
    SmsWorker.perform_async(mobile, message)
  end

  def send_reset_sms(mobile, code)
    message = "您在沃银网申请了绑定手机修改，您的验证码是#{code}【沃银金融】"
    SmsWorker.perform_async(mobile, message)
  end

  # def sendsms
  #   logger.info(params)
  # end


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
    if User.exists?(:username => params[:reg_phone])
      render :json => "false" and return
    else
      render :json => "true" and return
    end
  end


  def checkemail
    if User.exists?(:username => params[:reg_email])
      render :json => "false" and return
    else
      render :json => "true" and return
    end
  end

  def useractivate
    if params[:useremail]
      user = User.find_by email: params[:useremail]
      if user
        @message = "用户无效,激活失败"
        render "fail" and return
      end


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
      render :js => "alert('该手机号码已经被注册')" and return
    end
    verify_code = rand(10 ** 6)

    # send_sms(params[:phone_num], verify_code)
    if valid
      if valid.phonestatus == "verified"
        render :js => "alert('该手机号码已经被注册')" and return
      else
        valid.verify_code = verify_code
        valid.save!
        send_sms(params[:phone_num], verify_code)
        render :js => "" and return
      end
    else
      valid = Verification.new
      valid.phone = params[:phone_num]
      valid.verify_code = verify_code
      valid.save!
      send_sms(params[:phone_num], verify_code)
      render :js => "" and return
    end
  end


  def confirm_code
    valid = current_user.user_info.verification
    verify_code = rand(10 ** 6)
    valid.phone = params[:phone_num]
    valid.phonetime = Time.now
    valid.verify_code = verify_code
    valid.save!
    send_reset_sms(params[:phone_num], verify_code)
    render :js => "" and return
  end


  def test_json


    @pMerCode = params["pMerCode"]
    strxml = ""
    $pMerBillNo = params["pMerBillNo"]
    $pIdentType = params["pIdentType"]
    $pIdentNo = params["pIdentNo"]
    $pRealName = params["pRealName"]
    $pMobileNo = params["pMobileNo"]
    $pEmail = params["pEmail"]
    $pSmDate = params["pSmDate"]
    $pWebUrl = params["pWebUrl"]
    $pS2SUrl = params["pS2SUrl"]
    $pMemo1 = params["pMemo1"]
    $pMemo2 = params["pMemo2"]
    $pMemo3 = params["pMemo3"]

    $strxml = "<?xml version=\"1.0\" encoding=\"utf-8\"?>" +"<pReq>"+"<pMerBillNo>" + $pMerBillNo + "</pMerBillNo>" \
    + "<pIdentType>" + $pIdentType + "</pIdentType>" \
    + "<pIdentNo>" + $pIdentNo + "</pIdentNo>" \
    +"<pRealName>" + $pRealName + "</pRealName>" \
    +"<pMobileNo>" + $pMobileNo + "</pMobileNo>" \
    +"<pEmail>" + $pEmail + "</pEmail>" \
    +"<pSmDate>" + $pSmDate + "</pSmDate>" \
    +"<pWebUrl>" + $pWebUrl + "</pWebUrl>" \
    +"<pS2SUrl>" + $pS2SUrl + "</pS2SUrl>" \
    +"<pMemo1>" + $pMemo1 + "</pMemo1>" \
    +"<pMemo2>" + $pMemo2 + "</pMemo2>" \
    +"<pMemo3>" + $pMemo3 + "</pMemo3>" \
    +"</pReq>"


    url ="http://p2p.ips.net.cn/CreditWeb/CreateNewIpsAcct.aspx"
    # url ="http://127.0.0.1:8080/accounting/account/test_inter"
    ips_md5="GPhKt7sh4dxQQZZkINGFtefRKNPyAj8S00cgAwtRyy0ufD7alNC28xCBKpa6IU7u54zzWSAv4PqUDKMgpOnM7fucO1wuwMi4RgPAnietmqYIhHXZ3TqTGKNzkxA55qYH"
    des_key='ICHuQplJ0YR9l7XeVNKi6FMn'
    vec='2EDxsEfp'

    $strxml.gsub!(/[\s]{2,}/, "")
    $strxml.gsub!('\\', '')
    sec = encrypt($strxml, vec, des_key)


    # res = decrypt(sec, vec, des_key)
    str = @pMerCode + sec + ips_md5
    psign = Digest::MD5.hexdigest(str)


    # logger.info(res)

    # data={:argMerCode => '808801'}
    # uri = URI.parse(url)
    # http = Net::HTTP.new(uri.host, uri.port)
    # # # http.use_ssl = true
    # request = Net::HTTP::Post.new(uri.path, {'argMerCode' => pMerCode , 'arg3DesXmlPara' =>sec, 'argSign' => psign})
    # # # request.body = data.to_json
    # response = http.request(request)
    # # # op_res = JSON.parse response.body
    # logger.info("the result is #{response.body}" )

    logger.info("mcode is #{@pMerCode}")
    logger.info("param is #{sec.to_s.force_encoding("UTF-8")}")
    logger.info("psign is #{psign}")

    uri = URI(url)

    # logger.info("res is #{res}")

    # res = Net::HTTP.post_form(uri, 'argMerCode' => pMerCode , 'arg3DesXmlPara' =>sec, 'argSign' => psign, 'api_key' => "secret")
    #  puts res.body

    # op = AccountOperation.new(:op_name => "invest", :op_action => "buy", :operator => "system", :uinfo_id => current_user.user_info.id,
    #                           :op_asset_id => 12, :op_resource_id => 12)
    #
    #
    # op.execute_transaction
    @argMercode = @pMercode
    @arg3DesXmlPara = sec
    @argSign = psign

    render "test_json"
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
    @email_server = params[:reg_email]
    @email_server[0, @email_server.index('@')+1]="mail."
    render "success_email"
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


  def encrypt(data, vec, key)
    cipher = OpenSSL::Cipher::Cipher.new('DES-EDE3-CBC')
    cipher.encrypt # Must be called before anything else

    # Generate the key and initialization vector for the algorithm.
    # Alternatively, you can specify the initialization vector and cipher key
    # specifically using `cipher.iv = 'some iv'` and `cipher.key = 'some key'`
    cipher.iv = vec
    cipher.key = key
    # cipher.pkcs5_keyivgen('SOME_PASS_PHRASE_GOES_HERE')

    output = cipher.update(data)
    output << cipher.final
    output
    out = Base64.encode64(output).gsub(/\n/, "")
  end

  def decrypt(data, vec, key)
    # Effectively the same as the `encrypt` method
    cipher = OpenSSL::Cipher::Cipher.new('DES-EDE3-CBC')
    # cipher = OpenSSL::Cipher::Cipher.new('DES-EDE3-CBC')
    cipher.decrypt # Also must be called before anything else

    # cipher.pkcs5_keyivgen('SOME_PASS_PHRASE_GOES_HERE')
    cipher.iv = vec
    cipher.key = key

    output = cipher.update(data)
    output << cipher.final
    output
  end

end

