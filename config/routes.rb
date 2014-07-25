Wooul::Application.routes.draw do


  resources :analyzers

  resources :transactions

  resources :orders

  resources :coupons

  resources :bankcards

  resources :accounts

  devise_for :users
	#root :to => ''
  comfy_route :cms_admin, :path => '/cms-admin'

  resources :notices
  resources :invests, :fixed_deposits, :month_deposits
  resources :fixed_deposits do
    post :join
  end
	resource :home
	get 'accounts/:action', to: 'accounts'
	put 'accounts/:action', to: 'accounts'
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
    get '/console/create_order'
    post '/console/save_order'
    post '/console/charge_mock'
    resources :bankcards
    resources :accounts
    resources :coupons
  end

  comfy_route :cms, :path => '/', :sitemap => false


end
