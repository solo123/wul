Wooul::Application.routes.draw do
  devise_for :users
	#root :to => ''
  ComfortableMexicanSofa::Routing.admin(:path => '/cms-admin')
  
  resources :notices
  resources :invests, :fixed_deposits
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


  # Make sure this routeset is defined last
  ComfortableMexicanSofa::Routing.content(:path => '/', :sitemap => false)
end
