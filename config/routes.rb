require 'sidekiq/web'

Infinitory::Application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.

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

  match 'users/:id/activate' => 'users#activate', :as => 'activate_user', via: :get
  match 'users/:id/retire' => 'users#retire', :as => 'retire_user', via: :get  
  match 'users/:id/reject' => 'users#reject', :as => 'reject_user', via: :get

  post 'versions/:id/revert' => 'versions#revert', as: 'revert_version'

  mount Sidekiq::Web, at: '/sidekiq'
end
