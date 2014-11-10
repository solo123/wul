# coding: utf-8
class TestController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => :showparams
  before_filter :verify_custom_authenticity_token, :only => :showparams
  layout "public"
  def verify_custom_authenticity_token
    # checks whether the request comes from a trusted source
  end

  def showparams
    @params = params
  end


end

