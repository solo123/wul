Wooul::Application.routes.draw do
  devise_for :users
	#root :to => ''
  ComfortableMexicanSofa::Routing.admin(:path => '/cms-admin')
  
  resources :notices
  resources :invests, :fixed_deposits
	resource :home
	resources :accounts do
		get :secure
	end


  # Make sure this routeset is defined last
  ComfortableMexicanSofa::Routing.content(:path => '/', :sitemap => false)
end
