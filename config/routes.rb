Rails.application.routes.draw do

  devise_for :users
  root to: "stack#new"

  #User manipulation
  get 'users/:id' => 'users#show', :as => :user

  # Stack manipulation
  get 'stacks/:id' => 'stacks#show', :as => :stack
  get 'stacks/new' => 'stacks#new'
  post 'stacks/create' => 'stacks#create'
  get '/stacks/:id/edit' => 'stacks#edit', :as => :stack_edit
  post 'stacks/:id/update' => 'stacks#update'

  #card manipulation
  get 'cards/:id' => 'cards#show', :as => :card
  get 'stacks/:stack_id/cards/new' => 'cards#new'
  post 'stacks/:stack_id/cards/create' => 'cards#create'

  #Studying a stack
  post 'stacks/:id/add' => 'user_stacks#study_stack', :as => :study_stack


  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

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
