class AuthController < Devise::SessionsController
  def reg
    render :js => "alert('helloworld')"
    #render :js => "window.location.href = '/success'"
  end

  def success

  end

  def checkmobile
    if UserInfo.exists?(:mobile => params[:reg_phone])
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
      render :js => "alert('发送时报')"
    end
    valid.phone = params[:phone_num]
    valid.phonetime = Time.now
    valid.verify_code = "222222"
    valid.save!
  end

  def create
    valid = Verification.where(:phone => params[:reg_phone]).first
    if valid
      logger.info(valid.verify_code)
      puts params[:reg_code]
      if valid.verify_code == params[:reg_code]

        render :js => "alert('验证通过')"
      else
        render :js => "alert('验证没有通过')"
      end
    end




    #super do |resource|
    # BackgroundWorker.trigger(resource)
    #end
  end

end

