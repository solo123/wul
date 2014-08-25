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
    if valid
      render :js => "alert('验证码已经发送')"
    else
      valid = Verification.new
      render :js => "alert('验证码已经更新')"
    end
    valid.phone = params[:phone_num]
    valid.phonetime = Time.now
    valid.verify_code = "222222"
    valid.save!
  end

  def create
    valid = Verification.where(:phone => params[:reg_phone]).first
    if valid
      if User.exists?(:mobile => valid.phone)
        render :js => "alert('电话号码已经存在')" and return
      end
      if valid.verify_code == params[:reg_code]
        u=User.new
        u.mobile = valid.phone
        u.password = u.password_confirmation = params[:reg_password]
        u.save!
        valid.phonetime = Time.now
        u.user_info.verification = valid
        valid.save!

        render :js => "alert('验证通过')" and return
      end
    else
      render :js => "alert('验证没有通过')"
    end


    #super do |resource|
    # BackgroundWorker.trigger(resource)
    #end
  end

end

