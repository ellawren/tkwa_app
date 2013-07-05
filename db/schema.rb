# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130129185612) do

  create_table "bills", :force => true do |t|
    t.string   "date"
    t.decimal  "amount"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.integer  "consultant_team_id", :null => false
  end

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "categories_contacts", :id => false, :force => true do |t|
    t.integer  "category_id", :null => false
    t.integer  "contact_id",  :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "categories_contacts", ["category_id", "contact_id"], :name => "index_categories_contacts_on_category_id_and_contact_id", :unique => true

  create_table "consultant_roles", :force => true do |t|
    t.string   "consultant_role_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "consultant_roles_projects", :id => false, :force => true do |t|
    t.integer  "project_id",         :null => false
    t.integer  "consultant_role_id", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "consultant_roles_projects", ["project_id", "consultant_role_id"], :name => "index_cons_projects_on_project_id_and_consultant_role_id", :unique => true

  create_table "consultant_teams", :force => true do |t|
    t.integer  "project_id"
    t.integer  "consultant_id"
    t.datetime "created_at",                                         :null => false
    t.datetime "updated_at",                                         :null => false
    t.string   "consultant_role"
    t.decimal  "consultant_contract", :precision => 12, :scale => 2
  end

  add_index "consultant_teams", ["consultant_id"], :name => "index_consultant_teams_on_consultant_id"
  add_index "consultant_teams", ["project_id", "consultant_id", "consultant_role"], :name => "index_consultant_teams_on_role_and_ids", :unique => true
  add_index "consultant_teams", ["project_id"], :name => "index_consultant_teams_on_project_id"

  create_table "consultants", :force => true do |t|
    t.string   "company"
    t.string   "address"
    t.string   "phone"
    t.string   "contact"
    t.string   "contact_email"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "contacts", :force => true do |t|
    t.string   "name"
    t.string   "work_title"
    t.string   "work_company"
    t.string   "work_department"
    t.string   "work_address"
    t.string   "work_phone"
    t.string   "work_ext"
    t.string   "work_assistant"
    t.string   "work_direct"
    t.string   "work_fax"
    t.string   "work_email"
    t.string   "work_url"
    t.string   "home_address"
    t.string   "home_phone"
    t.string   "home_cell"
    t.string   "home_email"
    t.string   "staff_contact"
    t.text     "notes"
    t.boolean  "employee",        :default => false
    t.string   "category"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.string   "birthday"
    t.string   "direct_ext"
    t.string   "assistant"
    t.string   "work_cell"
    t.string   "post_nominals"
    t.string   "prefix"
    t.string   "cat01"
    t.string   "cat02"
    t.string   "cat03"
    t.string   "cat04"
    t.string   "cat05"
    t.string   "cat06"
  end

  create_table "data_records", :force => true do |t|
    t.integer  "year"
    t.decimal  "week",           :precision => 4, :scale => 2
    t.decimal  "vacation",       :precision => 6, :scale => 2
    t.decimal  "holiday",        :precision => 4, :scale => 2
    t.decimal  "billable",       :precision => 6, :scale => 2
    t.decimal  "rate",           :precision => 6, :scale => 2
    t.datetime "created_at",                                   :null => false
    t.datetime "updated_at",                                   :null => false
    t.integer  "employee_id"
    t.decimal  "admin_meeting",  :precision => 6, :scale => 2
    t.decimal  "computer",       :precision => 6, :scale => 2
    t.decimal  "education",      :precision => 6, :scale => 2
    t.decimal  "marketing",      :precision => 6, :scale => 2
    t.decimal  "staff_meeting",  :precision => 6, :scale => 2
    t.decimal  "stdio_projects", :precision => 6, :scale => 2
    t.decimal  "research",       :precision => 6, :scale => 2
  end

  create_table "data_records_employees", :id => false, :force => true do |t|
    t.integer  "data_record_id", :null => false
    t.integer  "employee_id",    :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "data_records_employees", ["data_record_id", "employee_id"], :name => "index_data_records_employees_on_data_record_id_and_employee_id", :unique => true

  create_table "employee_teams", :force => true do |t|
    t.integer  "contact_id"
    t.integer  "project_id"
    t.datetime "created_at",                               :null => false
    t.datetime "updated_at",                               :null => false
    t.string   "role"
    t.decimal  "pd_hours",   :precision => 6, :scale => 2
    t.decimal  "sd_hours",   :precision => 6, :scale => 2
    t.decimal  "dd_hours",   :precision => 6, :scale => 2
    t.decimal  "cd_hours",   :precision => 6, :scale => 2
    t.decimal  "bid_hours",  :precision => 6, :scale => 2
    t.decimal  "cca_hours",  :precision => 6, :scale => 2
    t.decimal  "int_hours",  :precision => 6, :scale => 2
    t.decimal  "his_hours",  :precision => 6, :scale => 2
    t.decimal  "add_hours",  :precision => 6, :scale => 2
  end

  add_index "employee_teams", ["contact_id"], :name => "index_employee_teams_on_contact_id"
  add_index "employee_teams", ["project_id", "contact_id"], :name => "index_employee_teams_on_project_id_and_contact_id", :unique => true
  add_index "employee_teams", ["project_id"], :name => "index_employee_teams_on_project_id"

  create_table "employees", :force => true do |t|
    t.integer  "user_id"
    t.integer  "contact_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "number"
    t.string   "status"
    t.string   "hire_date"
    t.string   "leave_date"
  end

  add_index "employees", ["contact_id"], :name => "index_employees_on_contact_id"
  add_index "employees", ["user_id", "contact_id"], :name => "index_employees_on_user_id_and_contact_id", :unique => true
  add_index "employees", ["user_id"], :name => "index_employees_on_user_id"

  create_table "globals", :force => true do |t|
    t.integer  "year"
    t.decimal  "multiplier", :precision => 4, :scale => 2
    t.decimal  "mileage",    :precision => 4, :scale => 2
    t.datetime "created_at",                               :null => false
    t.datetime "updated_at",                               :null => false
  end

  create_table "holidays", :force => true do |t|
    t.date     "date"
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "microposts", :force => true do |t|
    t.string   "content"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "microposts", ["user_id", "created_at"], :name => "index_microposts_on_user_id_and_created_at"

  create_table "non_billable_entries", :force => true do |t|
    t.integer  "timesheet_id"
    t.integer  "employee_id"
    t.string   "category"
    t.string   "description"
    t.decimal  "day1",         :precision => 4, :scale => 2
    t.decimal  "day2",         :precision => 4, :scale => 2
    t.decimal  "day3",         :precision => 4, :scale => 2
    t.decimal  "day4",         :precision => 4, :scale => 2
    t.decimal  "day5",         :precision => 4, :scale => 2
    t.decimal  "day6",         :precision => 4, :scale => 2
    t.decimal  "day7",         :precision => 4, :scale => 2
    t.datetime "created_at",                                 :null => false
    t.datetime "updated_at",                                 :null => false
  end

  create_table "phases", :force => true do |t|
    t.string   "name"
    t.integer  "number"
    t.string   "shorthand"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "full_name"
  end

  create_table "phases_projects", :id => false, :force => true do |t|
    t.integer  "project_id", :null => false
    t.integer  "phase_id",   :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "phases_projects", ["project_id", "phase_id"], :name => "index_phases_projects_on_project_id_and_phase_id", :unique => true

  create_table "projects", :force => true do |t|
    t.string   "name"
    t.decimal  "number",              :precision => 8,  :scale => 2
    t.string   "location"
    t.string   "client"
    t.string   "building_type"
    t.string   "client_type"
    t.string   "status"
    t.string   "contact_name"
    t.string   "contact_phone"
    t.string   "contact_email"
    t.string   "billing_name"
    t.string   "billing_address"
    t.string   "billing_phone"
    t.string   "billing_email"
    t.string   "billing_type"
    t.string   "billing_travel"
    t.string   "billing_consultant"
    t.string   "billing_outofpocket"
    t.datetime "created_at",                                         :null => false
    t.datetime "updated_at",                                         :null => false
    t.string   "billing_ext"
    t.string   "contact_ext"
    t.date     "start_date"
    t.date     "completion_date"
    t.date     "pd_start"
    t.date     "pd_end"
    t.date     "sd_start"
    t.date     "sd_end"
    t.date     "dd_start"
    t.date     "dd_end"
    t.date     "cd_start"
    t.date     "cd_end"
    t.date     "bid_start"
    t.date     "bid_end"
    t.date     "cca_start"
    t.date     "cca_end"
    t.date     "add_start"
    t.date     "add_end"
    t.integer  "pd_percent"
    t.integer  "sd_percent"
    t.integer  "dd_percent"
    t.integer  "cd_percent"
    t.integer  "bid_percent"
    t.integer  "cca_percent"
    t.integer  "his_percent"
    t.integer  "int_percent"
    t.integer  "add_percent"
    t.string   "client_url"
    t.decimal  "contract_amount",     :precision => 12, :scale => 2
    t.decimal  "extra_services",      :precision => 12, :scale => 2
    t.decimal  "payroll",             :precision => 12, :scale => 2
    t.string   "alt_contact"
    t.string   "mkt_location"
    t.string   "mkt_size"
    t.string   "mkt_cost"
    t.text     "mkt_description"
    t.string   "mkt_reference"
  end

  add_index "projects", ["number"], :name => "index_projects_on_number", :unique => true

  create_table "projects_reimbursables", :id => false, :force => true do |t|
    t.integer  "project_id",      :null => false
    t.integer  "reimbursable_id", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "projects_reimbursables", ["project_id", "reimbursable_id"], :name => "index_projects_reimbursables_on_project_id_and_reimbursable_id", :unique => true

  create_table "projects_services", :id => false, :force => true do |t|
    t.integer  "project_id", :null => false
    t.integer  "service_id", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "projects_services", ["project_id", "service_id"], :name => "index_projects_services_on_project_id_and_service_id", :unique => true

  create_table "projects_tasks", :id => false, :force => true do |t|
    t.integer  "project_id", :null => false
    t.integer  "task_id",    :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "projects_tasks", ["project_id", "task_id"], :name => "index_projects_tasks_on_project_id_and_task_id", :unique => true

  create_table "reimbursables", :force => true do |t|
    t.string   "reimbursable_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "relationships", :force => true do |t|
    t.integer  "follower_id"
    t.integer  "followed_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "relationships", ["followed_id"], :name => "index_relationships_on_followed_id"
  add_index "relationships", ["follower_id", "followed_id"], :name => "index_relationships_on_follower_id_and_followed_id", :unique => true
  add_index "relationships", ["follower_id"], :name => "index_relationships_on_follower_id"

  create_table "services", :force => true do |t|
    t.string   "service_name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "description"
  end

  create_table "tasks", :force => true do |t|
    t.string   "name"
    t.integer  "number"
    t.string   "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "time_entries", :force => true do |t|
    t.integer  "timesheet_id"
    t.integer  "project_id"
    t.string   "task"
    t.datetime "created_at",                                 :null => false
    t.datetime "updated_at",                                 :null => false
    t.decimal  "day1",         :precision => 4, :scale => 2
    t.decimal  "day2",         :precision => 4, :scale => 2
    t.decimal  "day3",         :precision => 4, :scale => 2
    t.decimal  "day4",         :precision => 4, :scale => 2
    t.decimal  "day5",         :precision => 4, :scale => 2
    t.decimal  "day6",         :precision => 4, :scale => 2
    t.decimal  "day7",         :precision => 4, :scale => 2
    t.integer  "employee_id"
    t.integer  "phase_number"
  end

  create_table "timesheets", :force => true do |t|
    t.integer  "year",                             :null => false
    t.integer  "week",                             :null => false
    t.integer  "employee_id",                      :null => false
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
    t.integer  "selected_year"
    t.boolean  "complete",      :default => false
  end

  add_index "timesheets", ["employee_id", "year", "week"], :name => "index_timesheets_on_employee_id_and_year_and_week", :unique => true

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.string   "password_digest"
    t.string   "remember_token"
    t.boolean  "admin",           :default => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["remember_token"], :name => "index_users_on_remember_token"

end
