TkwaApp::Application.routes.draw do


  resources :users do
    member do
      get :following, :followers, :profile
    end
  end
    
  resources :projects do
    resources :employee_teams
    get :autocomplete_contact_name, :on => :collection
    member do
      get 'info', 'team', 'scope', 'tracking', 'schedule'
    end
  end    

  resources :employees do
    resources :timesheets
  end
  match '/employees/:id/timesheets/:year/:week', to: 'timesheets#show'
  match '/employees/:id/data_records/:year', to: 'data_records#edit'

  resources :contacts do
    get :autocomplete_contact_work_company, :on => :collection
  end
  
  resources :categories 
  resources :consultants
  resources :data_records
  resources :employees
  resources :employee_teams
  resources :globals
  resources :holidays
  resources :microposts,  only: [:create, :destroy]
  resources :relationships, only: [:create, :destroy]
  resources :services
  resources :sessions, 		only: [:new, :create, :destroy]
  resources :tasks
  resources :timesheets, :only => [:index, :create, :update]
  
  match '/signup',	to: 'users#new'
  match '/signin',  to: 'sessions#new'
  match '/signout', to: 'sessions#destroy'
  match '/help',    to: 'static_pages#help'
  match '/about',   to: 'static_pages#about'
  match '/messages',to: 'static_pages#messages'
    
  root :to => 'static_pages#home'
  

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

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
