Rails.application.routes.draw do

  root to: 'users#index'

  patch 'locale/set'

  devise_for :users, controllers: {registrations: 'registrations'}

  resources :licenses

  resources :users, except: [:show] do
    get :invitations, on: :collection

    patch :resend, on: :member

    post :invite, on: :collection

    delete :invitation_destroy, on: :member
    delete :batch_destroy, on: :collection
  end

  resources :clients, except: [:show] do
    delete :batch_destroy, on: :collection
  end

  namespace :api do
  	namespace :v1 do
      post '/tokens', to: 'tokens#create'
      post '/app_data/get_data', to: 'app_data#create'
      post '/tokens/log_out', to: 'tokens#log_out'
      post '/tokens/generate', to: 'tokens#generate'
      post '/app_data/get_history', to: 'app_data#get_history'
	 end
  end

end
