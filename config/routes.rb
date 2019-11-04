Rails.application.routes.draw do
  
  namespace :api do
  	namespace :v1 do
      post '/tokens', to: 'tokens#create'
      post '/app_data/get_data', to: 'app_data#create'
      post '/tokens/log_out', to: 'tokens#log_out'
      post '/tokens/generate', to: 'tokens#generate'
      post '/app_data/get_history', to: 'app_data#get_history'
	 end
  end


  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
