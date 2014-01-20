TkwaApp::Application.routes.draw do

  
  get "errors/error_404"

  get "errors/error_500"

  post "/csv_import" => 'projects#csv_import'
  post "/cont_csv_import" => 'contacts#cont_csv_import'
  match '/projects/current',  to: 'projects#current'
  match '/projects/import',   to: 'projects#import'
  match '/contacts/import',   to: 'contacts#import'
  match '/projects/forecast',   to: 'projects#forecast_index'

  resources :projects do
    resources :employee_teams
    resources :schedule_items
    resources :shop_drawings
    get :autocomplete_contact_name, :on => :collection
    get :autocomplete_billing_name, :on => :collection
    get :autocomplete_contact_work_company, :on => :collection
    member do
      get 'info', 'team', 'scope', 'tracking', 'fee_calc', 'schedule', 'setup', 'schedule_full', 'billing', 'drawing_log', 'marketing', 'summary', 'current', 'patterns', 'forecast', 'edit_forecast'
    end
  end    
resources :projects
  resources :users do
    resources :timesheets
    member do
      get 'forecast', 'edit_forecast'
    end
  end

  match '/users/:id/timesheets/:year/:week',  to: 'timesheets#show'
  match '/users/:user_id/data_records',      to: 'data_records#user_index'
  match '/users/:user_id/data_records/:id',      to: 'data_records#edit'
  match '/globals/:year',                         to: 'globals#edit'
  match '/consultant_teams/:consultant_team_id/bills',            to: 'bills#index'

#need both of these for routing to work correctly on project billing page
resources :consultant_teams do
  resources :bills
end
resources :bills

resources :contacts do
    member do
      get 'data', 'employee_data', 'consultant_data', 'client_data'
    end
    get :autocomplete_contact_work_company, :on => :collection
    get :autocomplete_contact_name, :on => :collection
end

match '/phases/modal',   to: 'phases#modal', as: "modal_phases"

  resources :categories 
  resources :consultants
  resources :consultant_roles
  resources :data_records
  resources :employee_teams
  resources :globals, :only => [:index, :create, :update]
  resources :holidays
  resources :microposts,  only: [:create, :destroy]
  resources :messages
  resources :phases
  resources :plan_entries
  resources :reimbursables
  resources :relationships, only: [:create, :destroy]
  resources :schedule_items
  resources :services
  resources :sessions, 		only: [:new, :create, :destroy]
  resources :shop_drawings
  resources :tasks
  resources :timesheets, :only => [:index, :create, :update]

  get 'time_entries/update_phases', :as => 'update_phases'

  match '/patterns/browse',   to: 'patterns#browse'
  match '/patterns/browse/:id',   to: 'patterns#browse'
  match '/patterns/projects/:id',   to: 'patterns#projects'
  resources :patterns
  
  match '/signup',	to: 'users#new'
  match '/signin',  to: 'sessions#new'
  match '/signout', to: 'sessions#destroy'
  match '/help',    to: 'static_pages#help'
  match '/about',   to: 'static_pages#about'
  match '/messages',to: 'static_pages#messages'
  match '/admin',   to: 'static_pages#admin'
  match '/error',   to: 'static_pages#error'
  match '/potential_projects',   to: 'static_pages#potential_projects'

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
