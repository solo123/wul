module Usercenter
  class ConsoleController< ApplicationController
    layout "usercenter"
    def index

    end

    def overview
      @deposit = Account.where(:user_id => current_user.id).first
    end

    def history
    end

    def charge

    end

    def assets_analyzer

    end

    def redemption

    end

    def agreements

    end

    def autoinvest

    end

    def invest_history

    end

    def bankcard
      @bankcards = current_user.bankcards
    end

    def coupon
      @coupons =  current_user.coupons
    end
  end
end