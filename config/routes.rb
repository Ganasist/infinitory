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

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end
  
  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
