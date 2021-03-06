MBrowser7::Application.routes.draw do
  get "integrity/", :controller => 'integrity', :action => 'index'
  get "integrity/time_thumb"
  get "integrity/purge_thumb"
  
  post "logs/read_all", :as => 'logs_read_all'
  resources :logs

  resources :views do
    resource :conditions
  end

  match "tagging_room" => 'tagging_room#index', :as => 'tagging_room'

  post "tagging_room/tag"
  post "tagging_room/untag"

  get "tagging_room/find"

  match "tags" => 'tags#index'
  match "tags/:id" => 'tags#show'
  get "movies/row/" => 'movies#row', :as => 'movie_row'
  resources :movies
  match "movies/:id/thumbs" => 'movies#thumbs', :as => 'movie_thumbs'
  match "movies/:id/thumb" => 'movies#thumb', :as => 'movie_thumb'
  match 'dropbox' => 'dropbox#show'
  match 'add' => 'dropbox#add'
  match 'add_all' => 'dropbox#add_all'
  match 'system_files/process_all' => "system_files#process_all", :as => 'process_all_system_file'
  resources :system_files

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => "welcome#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
