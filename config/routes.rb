Wooul::Application.routes.draw do


  resources :stocks

  resources :analyzers

  resources :transactions

  resources :orders

  resources :coupons

  resources :bankcards

  resources :accounts

  post '/regist', to: 'auth#regist'

  devise_for :users, controllers: { registrations: "auth", sessions: "login" }
  devise_scope :user do
    post "/checkmobile" => "auth#checkmobile"
    post "/checkemail" => "auth#checkemail"
    post "/get_code" => "auth#get_code"
    post "/new_user" => "auth#create"
    get "/success" => "auth#success"
  end

  #root :to => ''
  comfy_route :cms_admin, :path => '/cms-admin'

  resources :notices
  resources :fixed_deposits do
    post :join
  end

  resources :month_deposits do
    post :join
  end

  get 'DCB', to: 'products#fixed_deposits', as: :product_fixed

  # resources :products do
  #   get :fixed_deposits
  # end

  resources :invests do
    post :buy
    collection do
      get :onsale
    end
  end

  resource :home
  #get 'accounts/:action', to: 'accounts'
  #put 'accounts/:action', to: 'accounts'
  #resources :accounts do
  #  collection do
  #		get :secure
  #  	get :password
  #		get :my_account
  #		put :password_update
  #	  get 'sec/:action'
  #	end
  #end

  namespace :usercenter do
    get '/', to: 'console#index'
    get '/console/overview'
    get '/console/history'
    get '/console/charge'
    get '/console/bankcard'
    get '/console/coupon'
    get '/console/assets_analyzer'
    get '/console/invest_history'
    get '/console/redemption'
    get '/console/agreements'
    get '/console/autoinvest'
    get '/console/charge_bank'
    post '/console/resell'
    get '/console/create_order'
    post '/console/save_order'
    post '/console/charge_mock'
    resources :bankcards
    resources :accounts
    resources :coupons
  end

  namespace :securecenter do
    get '/', to: 'secure#index'
    get '/secure/confirmphone'
    post '/secure/verify_code'
    post '/secure/checkphone'
  end


  comfy_route :cms, :path => '/', :sitemap => false


end
