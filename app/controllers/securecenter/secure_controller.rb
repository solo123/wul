module Securecenter
  class SecureController< ApplicationController
    layout "securecenter"

    before_filter :authenticate_user!, :set_cache_buster

    def index

    end

    def confirmphone

    end

    def real_name
      verification = current_user.user_info.verification
      if verification.idstatus == "verified"
        @verify = verification
      else
        if params[:id_number] == "370502198503126415"
          verification.realname = params[:real_name]
          verification.personalid = params[:id_number]
          verification.idstatus = "verified"
          verification.securyscore += 1
          verification.save!
        else
          flash[:notice] = "验证失败"
        end
      end

    end

    def set_real_name
      verification = current_user.user_info.verification
      if params[:id_number] == "370502198503126415"
        verification.realname = params[:real_name]
        verification.personalid = params[:id_number]
        verification.idstatus = "verified"
        verification.securyscore += 1
        verification.save!
        @verify = verification
        render "realname"
      else
        render "auth/fail"
      end
    end


    def check_real_name
      verification = current_user.user_info.verification
      if params[:id_number] == "370502198503126415"
        verification.realname = params[:real_name]
        verification.personalid = params[:id_number]
        verification.idstatus = "verified"
        verification.securyscore += 1
        verification.save!
      else
        flash[:notice] = "验证失败"
      end
      redirect_to securecenter_secure_real_name_path
    end


    def confirm
      @phone_confirm = current_user.user_info.verification.phone_confirm_status
    end


    def new_phone
      if params[:verify_code] == current_user.user_info.verification.verify_code
        render "new_phone" and return
      else
        render "auth/fail" and return
      end
    end

    def secure_active
      verify = current_user.user_info.verification
      verify.phone_confirm_status = !verify.phone_confirm_status
      verify.save!
      redirect_to securecenter_secure_confirm_path
    end

    def change_phone
      # if request.post?
      #   phonenum = params[:phone_number]
      #   secure_num = params[:secure_number]
      #   if UserInfo.exists?(:mobile => phonenum)
      #     flash[:notice] = "该号码已经被使用#{phonenum}"
      #   else
      #     uinfo =current_user.user_info
      #     verify = uinfo.verification
      #     if verify.phone == phonenum and secure_num == verify.verify_code
      #       verify.phonetime = Time.now
      #       uinfo.payment_password = params[:pay_password]
      #       verify.securyscore += 1
      #       verify.phonestatus = "verified"
      #       verify.save!
      #       uinfo.save!
      #       flash[:notice] = "验证成功"
      #     else
      #       flash[:notice] = "验证码与手机不符"
      #     end
      #   end
      # else
      #   verify = current_user.user_info.verification
      #   if verify.phonestatus == "verified"
      #     @verification = verify
      #   end
      # end
      verify = current_user.user_info.verification
      if verify.phonestatus == "verified"
        @verification = verify
      end
    end

    def change_email
    end


    def change_secret
    end

    def verify_code
      phonenum = params[:phone]
      verify_code = rand(10 ** 6)
      verify = current_user.user_info.verification
      verify.phone = phonenum
      verify.verify_code = verify_code
      verify.phonetime = Time.now
      verify.save!
      render :json => {:verify => verify_code}
    end

    def checkphone
      phonenum = params[:phone_number]
      secure_num = params[:secure_number]
      if UserInfo.exists?(:mobile => phonenum)
        flash[:notice] = "该号码已经被使用#{phonenum}"
        redirect_to securecenter_secure_change_phone_path and return
      else
        uinfo =current_user.user_info
        verify = uinfo.verification

        if verify.phone == phonenum and secure_num == verify.verify_code
          uinfo.mobile = phonenum
          uinfo.mobile_verify_date = Time.now
          uinfo.payment_password = params[:pay_password]
          uinfo.secury_score += 1
          verify.phonestatus = "verified"
          verify.save!
          uinfo.save!
          flash[:notice] = "验证成功"
          redirect_to securecenter_secure_change_phone_path and return
        else
          flash[:notice] = "验证码与手机不符"
          redirect_to securecenter_secure_change_phone_path and return
        end
      end
    end

    def set_cache_buster
      response.headers["Cache-Control"] = "no-cache, no-store, max-age=0, must-revalidate"
      response.headers["Pragma"] = "no-cache"
      response.headers["Expires"] = "Fri, 01 Jan 1990 00:00:00 GMT"
    end


    def change_question
    end
  end
end