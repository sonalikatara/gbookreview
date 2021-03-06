Gbookreview::Application.routes.draw do
  get "admin/index" => 'admin#index', :as => 'admin_home'
  get "sessions/new" => 'sessions#new', :as => 'admin_login'
  get "sessions/newReader/:reader_id" => 'sessions#newReader', constraints: {reader_id: /\d+/} , :as => 'reader_login'
  post "sessions/newReader/:reader_id" => 'sessions#createReaderGroup'
  post "sessions/new" => 'sessions#create' 
  get "sessions/create"
  delete "sessions/destroy" => 'sessions#destroy', :as => 'admin_logout'
  delete "sessions/destroyReader" => 'sessions#destroyReader', :as => 'reader_logout'
 # resources :reviews

 # root 'welcome#index'
  root 'reviews#searchbooks'
 
  get '/reviews/searchbooks' => 'reviews#searchbooks', :as => 'search_books'
  get '/reviews/showbook/:title' => 'reviews#showbook', :as => 'show_book'
  get '/reviews/showreader/:reader_id' => 'reviews#showreader', constraints: {id: /\d+/} ,  :as => 'show_reader'
  get '/reviews/showauthor/:author' => 'reviews#showauthor', constraints: {id: /\d+/} ,  :as => 'show_author'
  get '/reviews'=> 'reviews#index' , :as => 'reviews'
  post '/reviews' => 'reviews#create'
  get '/reviews/new' => 'reviews#new' , :as => 'new_review'
  get '/reviews/:id/edit' => 'reviews#edit', :as => 'edit_review'
  get '/reviews/:id' => 'reviews#show', constraints: {id: /\d+/} , :as => 'review'
  patch '/reviews/:id' => 'reviews#update' 
  put '/reviews/:id' => 'reviews#update'
  delete '/reviews/:id' => 'reviews#destroy'

  get '/contact_us' => 'static_pages#contact_us'
  get '/about' => 'static_pages#about'

  get '/groups/new' => 'groups#new' , :as => 'new_group'
  post '/groups' => 'groups#create'
   get '/groups/:group_id' => 'groups#show', constraints: {group_id: /\d+/} , :as => 'group'
   get '/groups' => 'groups#allgroups' , :as => 'all_groups'
   get '/groups/mygroup' => 'groups#mygroup', :as => 'my_group'
   post '/groups/mygroup' => 'groups#showmygroup'
   get '/groups/startgroup' => 'groups#startgroup', :as => 'start_group'
   post '/groups/startgroup' => 'groups#mailstartgrouprequest' 
   
  get '/readers/new' => 'readers#new', :as => 'new_reader'
  post '/readers' => 'readers#create'
  get '/reader/:id/edit' => 'readers#edit', :as => 'edit_reader'
  patch '/reader/:id' => 'readers#update'
  

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
