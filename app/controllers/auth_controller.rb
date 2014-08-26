class AuthController < Devise::SessionsController
  def reg
    render :js => "alert('helloworld')"
    #render :js => "window.location.href = '/success'"
  end

  def success

  end

  def checkmobile
    if User.exists?(:mobile => params[:reg_phone])
      render :json => "false" and return
    else
      render :json => "true" and return
    end
  end

  def get_code
    valid = Verification.where(:phone => params[:phone_num]).first
    verify_code = rand(10 ** 6)
    if valid
      render :js => "alert('验证码已经发送,验证码是#{verify_code}')"
    else
      valid = Verification.new
      render :js => "alert('验证码已经更新,验证码是#{verify_code}')"
    end
    valid.phone = params[:phone_num]
    valid.phonetime = Time.now
    valid.verify_code = verify_code
    valid.save!
  end

  def create
    valid = Verification.where(:phone => params[:reg_phone]).first
    if valid
       if User.exists?(:mobile => valid.phone)
         render :js => "alert('电话号码已经存在,请用别的号码注册')" and return
       end
       if valid.verify_code == params[:reg_code]
         u=User.new
         u.mobile = valid.phone
         u.password = u.password_confirmation = params[:reg_password]
         u.save!
         valid.phonetime = Time.now
         u.user_info.verification = valid
         valid.save!
         render :js => "window.location.href = '/success'" and return
         #render :js => "alert('验证通过')" and return
       end
    else
      logger.info("position 3")
      render :js => "alert('验证没有通过')" and return
    end
    logger.info("position 4")
    render :js => "alert('验证码无效,请重新申请')" and return

    #super do |resource|
    # BackgroundWorker.trigger(resource)
    #end
  end

end

