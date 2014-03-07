TkwaApp::Application.routes.draw do

    # PROJECTS
    match '/projects/current',  to: 'projects#current'
    match '/projects/forecast',   to: 'projects#forecast_index'
    match '/projects/import',   to: 'projects#import'
    resources :projects do
        resources :employee_teams
        resources :schedule_items
        resources :shop_drawings
        get :autocomplete_contact_name, :on => :collection
        get :autocomplete_billing_name, :on => :collection
        get :autocomplete_contact_work_company, :on => :collection
        member do
            get 'info', 'team', 'scope', 'tracking', 'fee_calc', 'schedule', 'schedule_full', 'billing', 'drawing_log', 'marketing', 'patterns', 'forecast', 'edit_forecast'
        end
    end    
    

    # USERS / TIMESHEETS / VACATIONS / EXPENSE REPORTS
    match '/users/:id/timesheets/:year',                to: 'timesheets#user_index', as: 'user_index_timesheets'
    match '/users/:id/timesheets/:year/:week',          to: 'timesheets#edit', as: 'user_timesheet'
    match '/users/:id/timesheets/:year/:week/print',    to: 'timesheets#print', as: 'print_timesheet'
    match '/users/:user_id/data_records',               to: 'data_records#user_index'

    match '/timesheets/all/:year/:week',                to: 'timesheets#all', as: 'all_timesheets'

    match '/users/:user_id/data_records/:id',           to: 'data_records#edit', as: 'user_data_record'
    match '/vacations',  to: 'vacations#all',           as: 'all_vacations'

    resources :users do
        resources :timesheets
        resources :vacations
        resources :expense_reports
        resources :vacation_records
        member do
            get 'forecast', 'edit_forecast'
        end
        get :autocomplete_billing_name, :on => :collection
    end

    # EXPENSE REPORTS
    resources :expense_reports

    
    # CONSULTANT TEAMS / BILLS
    match '/consultant_teams/:consultant_team_id/bills',            to: 'bills#index'
    #need both of these for routing to work correctly on project billing page
    resources :consultant_teams do
      resources :bills
    end
    resources :bills
    

    # CONTACTS
    post "/csv_import" => 'projects#csv_import'
    post "/cont_csv_import" => 'contacts#cont_csv_import'
    match '/contacts/import',   to: 'contacts#import'
    match '/contacts/employees',   to: 'contacts#employees'
    resources :contacts do
        get :autocomplete_contact_work_company, :on => :collection
        get :autocomplete_contact_name, :on => :collection
        member do
            get 'transmittal', 'fax', 'envelope'
        end
    end
    

    # PHASES
    match '/phases/modal',   to: 'phases#modal', as: "modal_phases"
    get 'time_entries/update_phases', :as => 'update_phases'
    resources :phases


    # PATTERNS
    match '/patterns/browse',   to: 'patterns#browse'
    match '/patterns/browse/:id',   to: 'patterns#browse'
    match '/patterns/projects/:id',   to: 'patterns#projects'
    resources :patterns


    # STATIC PAGES
    match '/help',    to: 'static_pages#help'
    match '/about',   to: 'static_pages#about'
    match '/admin',   to: 'static_pages#admin'
    match '/error',   to: 'static_pages#error'
    match '/potential_projects',   to: 'static_pages#potential_projects'

    # MAILING LISTS
    resources :mailing_lists
    resources :list_members do
        get :autocomplete_contact_name, :on => :collection
    end

    resources :categories 
    resources :consultant_roles
    resources :data_records
    resources :employee_roles
    resources :employee_teams
    resources :globals, :only => [:index, :create, :update]
    resources :holidays
    resources :microposts,  only: [:create, :destroy]
    resources :messages
    resources :non_billable_categories
    resources :plan_entries
    resources :reimbursables
    resources :relationships, only: [:create, :destroy]
    resources :schedule_items
    resources :services
    resources :sessions, 		only: [:new, :create, :destroy]
    resources :shop_drawings
    resources :tasks
    resources :timesheets, :only => [:index, :create, :update]
    resources :vacation_records

    match '/signup',	to: 'users#new'
    match '/signin',  to: 'sessions#new'
    match '/signout', to: 'sessions#destroy'
    match '/globals/:year',   to: 'globals#edit'

    root :to => 'static_pages#home'
  
end
