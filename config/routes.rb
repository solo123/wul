Wooul::Application.routes.draw do
  devise_for :users
	#root :to => ''
  ComfortableMexicanSofa::Routing.admin(:path => '/cms-admin')
  
  resources :notices
  resources :invests, :fixed_deposits
	resource :home
	resources :accounts do
	  collection do 	
  		get :secure
	  	get :password
			get :my_account
			put :password_update
		end
	end


  # Make sure this routeset is defined last
  ComfortableMexicanSofa::Routing.content(:path => '/', :sitemap => false)
end
