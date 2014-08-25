TkwaApp::Application.routes.draw do

    # PROJECTS
    match '/projects/current',  to: 'projects#current'
    match '/projects/forecast',   to: 'projects#forecast_index'
    match '/projects/marketing',  to: 'projects#marketing_index', as: 'marketing_index'
    post '/csv_import' => 'projects#csv_import'
    match '/projects/import',   to: 'projects#import'
    match '/projects/fees_billed_by_month',   to: 'projects#fees_billed_by_month', as: 'fees_billed_by_month'
     match '/projects/billing_worksheet',   to: 'projects#billing_worksheet', as: 'billing_worksheet'
    match '/projects/all' => 'projects#update_all', :as => :update_all, :via => :put
    resources :projects do
        resources :employee_teams
        resources :schedule_items
        resources :shop_drawings
        resources :actuals
        resources :unassigned_hours
        get :autocomplete_contact_name, :on => :collection
        get :autocomplete_billing_name, :on => :collection
        get :autocomplete_contact_work_company, :on => :collection
        member do
            get 'info', 'team', 'scope', 'tracking', 'fee_calc', 'schedule', 'schedule_full', 'billing', 'drawing_log', 'marketing', 'patterns', 'forecast', 'edit_forecast'
        end
    end    
    resources :employee_teams
    

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
        resources :available_hours
        resources :non_billable_hours
        member do
            get 'forecast', 'edit_forecast'
        end
        get :autocomplete_billing_name, :on => :collection
    end

    # EXPENSE REPORTS
    resources :expense_reports
    resources :expense_items

    
    # CONSULTANT TEAMS / BILLS
    match '/consultant_teams/:consultant_team_id/bills',            to: 'bills#index'
    #need both of these for routing to work correctly on project billing page
    resources :consultant_teams do
      resources :bills
    end
    resources :bills
    

    # CONTACTS
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
    get 'time_entries/update_task_field', :as => 'update_task_field'
    resources :phases


    # PATTERNS
    post "/patt_csv_import" => 'patterns#patt_csv_import'
    match '/patterns/import',   to: 'patterns#import'
    match '/patterns/all',   to: 'patterns#all', as: 'all_patterns'
    match '/patterns/by_project/',   to: 'patterns#by_project', as: 'all_patterns_by_project'
    match '/patterns/by_project/:id',   to: 'patterns#projects', as: 'patterns_by_project'
    match '/patterns/by_project/:id/print',   to: 'patterns#print', as: 'patterns_print'
    match '/patterns/by_project/:id/print_tabloid',   to: 'patterns#print_tabloid', as: 'patterns_print_tabloid'
    match '/patterns/by_project/:id/simple',   to: 'patterns#simple', as: 'patterns_simple'
    resources :patterns do
        resources :pattern_images
    end
    resources :pattern_images


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

    # LIBRARY
    post "/lib_csv_import" => 'books#lib_csv_import'
    match '/library',    to: 'books#index'
    match '/library/import',   to: 'books#import'
    match '/library/checked_out',   to: 'books#checked_out', as: "checked_out"
    match '/library/recommendations',   to: 'books#recommendations', as: "recommendations"
    resources :books do 
        get :autocomplete_contact_name, :on => :collection
    end

    resources :billing_types
    resources :building_types
    resources :categories 
    resources :consultant_roles
    resources :data_records
    resources :employee_roles
    resources :globals, :only => [:index, :create, :update]
    resources :holidays
    resources :microposts,  only: [:create, :destroy]
    resources :messages
    resources :non_billable_categories
    resources :pattern_groups
    resources :plan_entries
    resources :reimbursables
    resources :relationships, only: [:create, :destroy]
    resources :schedule_items
    resources :services
    resources :sessions, 		only: [:new, :create, :destroy]
    resources :subjects
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
