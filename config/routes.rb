SpeedReading::Application.routes.draw do
  resources :word_pairs

  resources :categories

  resources :languages

  resources :contents do
    resources :questions
  end

  resources :reading_speed_tests, :only => [:new, :create, :show] do
    resources :comprehension_tests
  end

  resources :synonyms_and_antonyms_tests, :only => [:new, :create, :show]

  resources :scrambled_word_tests, :only => [:new, :create, :show] do
    resources :comprehension_tests
  end

  resources :word_search_tests, :only => [:new, :create, :show]

  match 'flashing_numbers_tests/chart' => 'flashing_numbers_tests#chart'
  resources :flashing_numbers_tests, :only => [:new, :create, :update, :show]

  match 'flashing_dots_tests/chart' => 'flashing_dots_tests#chart'
  resources :flashing_dots_tests, :only => [:new, :create, :update, :show]

  match 'flash_reading_tests/chart' => 'flash_reading_tests#chart'
  resources :flash_reading_tests, :only => [:new, :create, :show]

  devise_for :users

  resources :registered_users, :only => [:index, :edit, :update, :destroy]


  root :to => 'home#index'

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
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
