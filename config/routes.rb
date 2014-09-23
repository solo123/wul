#require 'sidekiq/web'
Wooul::Application.routes.draw do

 # mount Sidekiq::Web, at: "/sidekiq"

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
    post "/send_sms" => "auth#send_sms"
    post "/get_code" => "auth#get_code"
    post "/confirm_code" => "auth#confirm_code"
    post "/test_json" => "auth#test_json"
    post "/new_user" => "auth#create"
    get "/email_activate" => "auth#useractivate"
    get "/success" => "auth#success"
    get "/fail" => "auth#fail"
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

  get '/products/:product_type', to: 'products#index', as: :product_list
  get '/products/:product_type/:id', to: 'products#detail', as: :product_detail
  post '/products/:product_type/:id/join', to: 'products#join', as: :product_join

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
    get '/console/invest_detail'
    post '/console/setup_autoinvest', as: :setup_auto_invest
    get '/console/charge_bank'
    post '/console/resell'
    get '/console/create_order'
    get '/console/show_agreement'
    post '/console/save_order'
    post '/console/charge_mock'
    post '/console/open_auto_invest'
    resources :bankcards
    resources :accounts
    resources :coupons
  end

  namespace :securecenter do
    get '/', to: 'secure#index'
    get '/secure/confirmphone'
    get '/secure/real_name'
    get '/secure/secure_active'
    post '/secure/real_name'
    get '/secure/confirm'
    get '/secure/change_phone'
    post '/secure/change_phone'
    get '/secure/change_email'
    get '/secure/change_secret'
    post '/secure/verify_code'
    post '/secure/checkphone'
  end


  comfy_route :cms, :path => '/', :sitemap => false


end
