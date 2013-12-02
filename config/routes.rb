require 'sidekiq/web'

Infinitory::Application.routes.draw do

  authenticated :user do
    root :to => 'users#show', as: :authenticated_root
  end

  root :to => 'high_voltage/pages#show', id: 'splash'

  devise_for :users, :path => '', :path_names => { sign_in: 'login', sign_out: 'logout', sign_up: 'register' },
                                  :controllers => { registrations: 'registrations' }
 
  resources :institutes, shallow: true do
    resources :departments
    resources :labs do
      resources :reagents
      resources :users
    end
  end

  resources :user, except: [:index, :show, :new, :create, :edit, :update, :delete] do
    resources :reagents, only: [:index, :show]
  end

  resources :activities

  get 'tags/:tag', to: 'reagents#index', as: :tag

  match 'users/:id/activate' => 'users#activate', :as => 'activate_user', via: :get
  match 'users/:id/retire' => 'users#retire', :as => 'retire_user', via: :get  
  match 'users/:id/reject' => 'users#reject', :as => 'reject_user', via: :get

  post 'versions/:id/revert' => 'versions#revert', as: 'revert_version'

  mount Sidekiq::Web, at: '/sidekiq'

  # match '(errors)/:status', to: 'errors#show', constraints: {status: /\d{3}/ }, via: :get
end
