class AuthController < ApplicationController
  def regist
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
end

