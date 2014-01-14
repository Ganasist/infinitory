require 'sidekiq/web'
require 'sidetiq/web'

Infinitory::Application.routes.draw do

  resources :resources do
	  resources :bookings
	end

  resources :messages, only: [:new, :create]

  authenticated :user do
    root to: 'users#show', as: :authenticated_root
  end

  root :to => 'high_voltage/pages#show', id: 'splash'

  devise_for :users, path: '', path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'register' },
                                  controllers: { registrations: 'registrations', invitations: 'users/invitations' }
 
  resources :institutes, shallow: true do
    resources :labs do
      resources :devices
      resources :reagents
      resources :users
    end
  end

  resources :institutes do
    resources :departments
  end

  resources :user, except: [:index, :show, :new, :create, :edit, :update, :delete] do
    resources :reagents, only: [:index, :show]
    resources :devices,  only: [:index, :show]
  end

  get 'tags/:tag', to: 'reagents#index', as: :tag

  match 'users/:id/activate' => 'users#activate', as: 'activate_user', via: :get
  match 'users/:id/retire' => 'users#retire', as: 'retire_user', via: :get  
  match 'users/:id/reject' => 'users#reject', as: 'reject_user', via: :get

  match 'reagents/:id/clone' => 'reagents#clone', as: 'clone_reagent', via: :get
  match 'devices/:id/clone' => 'devices#clone', as: 'clone_device', via: :get

  post 'versions/:id/revert' => 'versions#revert', as: 'revert_version'

  mount Sidekiq::Web, at: '/sidekiq'

  # match '(errors)/:status', to: 'errors#show', constraints: {status: /\d{3}/ }, via: :get
end
