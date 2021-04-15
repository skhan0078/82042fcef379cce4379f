Rails.application.routes.draw do
  namespace :api do
	  resources :robot do
	  	post 'order', :on => :member
	  end
	end
end
