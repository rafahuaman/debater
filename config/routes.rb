Debater::Application.routes.draw do
  
  

  resources :argument_posts

  resources :contribution_posts, :controller => "argument_posts", :type => "ContributionPost"
  resources :original_posts, :controller => "argument_posts", :type => "OriginalPost"
  resources :correction_posts, :controller => "argument_posts", :type => "CorrectionPost"
  resources :counter_argument_posts, :controller => "argument_posts", :type => "CounterArgumentPost"

  resources :chambers

  resources :votes, only: [:create, :update, :destroy]

  match '/signup', to: 'users#new', via: 'get'
  
  resources :users
  resources :sessions, only: [:new, :create, :destroy]
  resources :debates

  #get "static_pages/home"
  #get "static_pages/about"
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'debates#index'

  # Example of regular route:
  match '/about', to: 'static_pages#about', via: 'get'
  match '/signup', to: 'users#new', via: 'get'
  match '/signin', to: 'sessions#new', via: 'get'
  match '/signout', to: 'sessions#destroy', via: 'delete'
  match '/delete/:id', to: 'users#delete', via: 'get', as: :delete_user
  #get 'about' => 'static_pages#about'
  
  

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

