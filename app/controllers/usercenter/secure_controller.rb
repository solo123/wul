module Usercenter
  class SecureController< ApplicationController
    layout "usercenter"

    before_filter :authenticate_user!, :set_cache_buster

    def index

    end

    def confirm_phone

    end


    end
end