module Securecenter
  class SecureController< ApplicationController
    layout "securecenter"

    before_filter :authenticate_user!, :set_cache_buster

    def index

    end

    def confirmphone

    end

    def checkphone
      phonenum=params[:phone_number]
      if UserInfo.exists?(:mobile => phonenum)
        flash[:notice] = "该号码已经被使用#{phonenum}"
        redirect_to securecenter_secure_confirmphone_path and return
      else
        flash[:notice] = "验证码已经发送到手机：#{phonenum},验证码是：12234"
        verify = current_user.user_info.verification
        verify.phone = phonenum
        verify.verify_code = "12234"
        verify.phonetime = Time.now
        verify.save!

        current_user.save!
        redirect_to securecenter_secure_confirmphone_path and return
      end
    end

    def set_cache_buster
      response.headers["Cache-Control"] = "no-cache, no-store, max-age=0, must-revalidate"
      response.headers["Pragma"] = "no-cache"
      response.headers["Expires"] = "Fri, 01 Jan 1990 00:00:00 GMT"
    end

  end
end