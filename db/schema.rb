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

ActiveRecord::Schema.define(:version => 20140815182240) do

  create_table "actuals", :force => true do |t|
    t.integer  "year"
    t.integer  "month"
    t.integer  "project_id"
    t.decimal  "amount",     :precision => 8, :scale => 2, :default => 0.0
    t.datetime "created_at",                                                :null => false
    t.datetime "updated_at",                                                :null => false
  end

  add_index "actuals", ["project_id"], :name => "index_actuals_on_project_id"

  create_table "available_hours", :force => true do |t|
    t.integer  "hours"
    t.integer  "user_id"
    t.integer  "year"
    t.integer  "week"
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
    t.boolean  "active",     :default => true
  end

  add_index "available_hours", ["user_id"], :name => "available_hours_user_id"

  create_table "billing_types", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "bills", :force => true do |t|
    t.string   "date"
    t.decimal  "amount",             :precision => 10, :scale => 2
    t.datetime "created_at",                                        :null => false
    t.datetime "updated_at",                                        :null => false
    t.integer  "consultant_team_id",                                :null => false
    t.string   "invoice_number"
    t.string   "date_approved"
  end

  add_index "bills", ["consultant_team_id"], :name => "index_bills_on_consultant_team_id"

  create_table "books", :force => true do |t|
    t.text     "title"
    t.string   "author"
    t.integer  "index"
    t.string   "shelf_location"
    t.string   "material_type",      :default => "Book"
    t.text     "loc_data"
    t.datetime "created_at",                                   :null => false
    t.datetime "updated_at",                                   :null => false
    t.string   "description"
    t.integer  "subject_id"
    t.string   "date"
    t.text     "categories"
    t.string   "status",             :default => "On Shelves"
    t.string   "borrower"
    t.datetime "date_checked_out"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
  end

  add_index "books", ["subject_id"], :name => "index_books_on_subject_id"

  create_table "building_types", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "number"
  end

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

  create_table "consultant_teams", :force => true do |t|
    t.integer  "project_id"
    t.datetime "created_at",                                         :null => false
    t.datetime "updated_at",                                         :null => false
    t.string   "consultant_role"
    t.decimal  "consultant_contract", :precision => 12, :scale => 2
    t.string   "consultant_name"
  end

  add_index "consultant_teams", ["project_id"], :name => "index_consultant_teams_on_project_id"

  create_table "contacts", :force => true do |t|
    t.string   "name"
    t.string   "work_title"
    t.string   "work_department"
    t.string   "work_ext"
    t.string   "work_direct"
    t.string   "work_email"
    t.string   "home_address"
    t.string   "home_phone"
    t.string   "home_cell"
    t.string   "home_email"
    t.string   "staff_contact"
    t.text     "notes"
    t.boolean  "employee",        :default => false
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.string   "birthday"
    t.string   "direct_ext"
    t.string   "work_cell"
    t.string   "cat_number"
    t.integer  "company_id"
    t.string   "work_company"
    t.string   "work_address"
    t.string   "work_phone"
    t.string   "work_url"
    t.string   "work_fax"
  end

  add_index "contacts", ["company_id"], :name => "index_contacts_on_company_id"

  create_table "data_records", :force => true do |t|
    t.integer  "year"
    t.decimal  "holiday",           :precision => 4, :scale => 2
    t.datetime "created_at",                                                            :null => false
    t.datetime "updated_at",                                                            :null => false
    t.integer  "user_id",                                                               :null => false
    t.string   "pay_type",                                        :default => "Salary"
    t.integer  "start_week"
    t.integer  "end_week"
    t.decimal  "hours_in_week",     :precision => 4, :scale => 2
    t.decimal  "overage_from_prev", :precision => 6, :scale => 2
    t.decimal  "billable_rate",     :precision => 5, :scale => 2
    t.decimal  "billable_per_week", :precision => 4, :scale => 2
  end

  add_index "data_records", ["user_id", "year"], :name => "index_data_records_on_user_id_and_year", :unique => true

  create_table "data_records_users", :id => false, :force => true do |t|
    t.integer  "data_record_id", :null => false
    t.integer  "user_id",        :null => false
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  add_index "data_records_users", ["data_record_id", "user_id"], :name => "index_data_records_users_on_data_record_id_and_user_id", :unique => true

  create_table "employee_roles", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "employee_teams", :force => true do |t|
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
    t.integer  "user_id"
    t.decimal  "rate",       :precision => 5, :scale => 2
  end

  add_index "employee_teams", ["project_id"], :name => "index_employee_teams_on_project_id"
  add_index "employee_teams", ["user_id"], :name => "index_employee_teams_on_user_id"

  create_table "employees", :force => true do |t|
    t.integer  "contact_id"
    t.integer  "user_id"
    t.integer  "employee_number"
    t.string   "hire_date"
    t.string   "leave_date"
    t.integer  "birth_month"
    t.integer  "birth_day"
    t.text     "family"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "employees", ["contact_id", "user_id"], :name => "index_employees_on_contact_id_and_user_id", :unique => true
  add_index "employees", ["contact_id"], :name => "index_employees_on_contact_id"
  add_index "employees", ["user_id"], :name => "index_employees_on_user_id"

  create_table "expense_items", :force => true do |t|
    t.integer  "expense_report_id"
    t.integer  "project_id"
    t.string   "date"
    t.string   "description"
    t.integer  "miles"
    t.decimal  "food",              :precision => 6, :scale => 2
    t.decimal  "parking",           :precision => 6, :scale => 2
    t.decimal  "misc",              :precision => 6, :scale => 2
    t.datetime "created_at",                                      :null => false
    t.datetime "updated_at",                                      :null => false
  end

  create_table "expense_reports", :force => true do |t|
    t.integer  "user_id",                         :null => false
    t.boolean  "complete",     :default => false
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
    t.boolean  "printed",      :default => false
    t.date     "date_printed"
  end

  create_table "globals", :force => true do |t|
    t.integer  "year"
    t.decimal  "multiplier", :precision => 4, :scale => 2
    t.decimal  "mileage",    :precision => 4, :scale => 2
    t.datetime "created_at",                               :null => false
    t.datetime "updated_at",                               :null => false
  end

  create_table "holidays", :force => true do |t|
    t.string   "date"
    t.string   "name"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.date     "date_object"
    t.integer  "year"
    t.integer  "week"
    t.integer  "day"
  end

  create_table "list_members", :force => true do |t|
    t.integer  "contact_id"
    t.integer  "mailing_list_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.string   "contact_name"
  end

  add_index "list_members", ["contact_id", "mailing_list_id"], :name => "index_list_members_on_contact_id_and_mailing_list_id", :unique => true
  add_index "list_members", ["contact_id"], :name => "index_list_members_on_contact_id"
  add_index "list_members", ["mailing_list_id"], :name => "index_list_members_on_mailing_list_id"

  create_table "mailing_lists", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "messages", :force => true do |t|
    t.string   "content"
    t.integer  "user_id"
    t.integer  "project_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "category"
    t.string   "expiration"
    t.date     "exp_date"
  end

  add_index "messages", ["user_id", "project_id"], :name => "index_messages_on_user_id_and_project_id"

  create_table "non_billable_categories", :force => true do |t|
    t.string   "name"
    t.string   "shorthand"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "non_billable_entries", :force => true do |t|
    t.integer  "timesheet_id"
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
    t.integer  "user_id",                                    :null => false
  end

  add_index "non_billable_entries", ["timesheet_id", "user_id"], :name => "index_nb_entries_on_timesheet_id_and_user_id"

  create_table "non_billable_hours", :force => true do |t|
    t.integer  "hours"
    t.integer  "year"
    t.integer  "week"
    t.integer  "user_id"
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
    t.boolean  "active",     :default => true
  end

  add_index "non_billable_hours", ["user_id"], :name => "non_billable_hours_user_id"

  create_table "pattern_groups", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "order"
  end

  create_table "pattern_images", :force => true do |t|
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.integer  "pattern_id"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.text     "caption"
  end

  create_table "patterns", :force => true do |t|
    t.string   "name"
    t.text     "issue"
    t.text     "solution"
    t.string   "author"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
    t.integer  "project_id"
    t.integer  "number"
    t.integer  "rating"
    t.text     "challenges"
    t.string   "diagram_file_name"
    t.string   "diagram_content_type"
    t.integer  "diagram_file_size"
    t.datetime "diagram_updated_at"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.integer  "pattern_group_id"
    t.text     "notes"
    t.text     "sources"
    t.text     "photo_caption"
    t.text     "diagram_caption"
  end

  add_index "patterns", ["project_id"], :name => "index_patterns_on_project_id"

  create_table "phases", :force => true do |t|
    t.string   "name"
    t.integer  "number"
    t.string   "shorthand"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.string   "full_name"
    t.text     "description"
  end

  create_table "phases_projects", :id => false, :force => true do |t|
    t.integer  "project_id", :null => false
    t.integer  "phase_id",   :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "phases_projects", ["project_id", "phase_id"], :name => "index_phases_projects_on_project_id_and_phase_id", :unique => true

  create_table "plan_entries", :force => true do |t|
    t.integer  "project_id",                                                       :null => false
    t.decimal  "hours",            :precision => 3, :scale => 0
    t.integer  "year",                                                             :null => false
    t.integer  "week",                                                             :null => false
    t.datetime "created_at",                                                       :null => false
    t.datetime "updated_at",                                                       :null => false
    t.integer  "user_id",                                                          :null => false
    t.integer  "employee_team_id"
    t.boolean  "active",                                         :default => true
  end

  add_index "plan_entries", ["employee_team_id"], :name => "plan_entries_employee_team_id"
  add_index "plan_entries", ["project_id"], :name => "plan_entries_project_id"
  add_index "plan_entries", ["user_id"], :name => "plan_entries_user_id"

  create_table "projects", :force => true do |t|
    t.string   "name"
    t.string   "number"
    t.string   "location"
    t.string   "client"
    t.string   "client_type"
    t.string   "status",                                               :default => "current"
    t.string   "contact_name"
    t.string   "contact_phone"
    t.string   "contact_email"
    t.string   "billing_name"
    t.string   "billing_address"
    t.string   "billing_phone"
    t.string   "billing_email"
    t.datetime "created_at",                                                                                                                     :null => false
    t.datetime "updated_at",                                                                                                                     :null => false
    t.string   "billing_ext"
    t.string   "contact_ext"
    t.string   "start_date"
    t.string   "completion_date"
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
    t.decimal  "contract_amount",       :precision => 12, :scale => 2
    t.decimal  "payroll",               :precision => 12, :scale => 2
    t.string   "alt_contact"
    t.string   "mkt_location"
    t.string   "mkt_size"
    t.string   "mkt_cost"
    t.text     "mkt_description"
    t.string   "mkt_reference"
    t.string   "mkt_status"
    t.string   "view_options",                                         :default => "---\n- setup\n- scope\n- forecast\n- tracking\n- billing\n"
    t.string   "proposal_date"
    t.string   "interview_date"
    t.string   "awarded",                                              :default => "pending"
    t.string   "contact_address"
    t.decimal  "billed_to_date",        :precision => 12, :scale => 2
    t.decimal  "hourly_billed_to_date", :precision => 12, :scale => 2
    t.boolean  "recent_billing",                                       :default => false
    t.string   "cm"
    t.integer  "building_type_id"
    t.integer  "billing_type_id"
  end

  add_index "projects", ["name"], :name => "index_projects_on_name"

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

  create_table "recommendations", :force => true do |t|
    t.integer  "book_id"
    t.integer  "user_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.text     "description"
  end

  add_index "recommendations", ["book_id", "user_id"], :name => "index_recommendations_on_book_id_and_user_id"

  create_table "reimbursables", :force => true do |t|
    t.string   "reimbursable_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "schedule_items", :force => true do |t|
    t.integer  "project_id"
    t.integer  "phase_id"
    t.string   "desc"
    t.string   "start"
    t.string   "end"
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
    t.string   "duration"
    t.date     "start_date"
    t.string   "meeting",    :default => "task"
  end

  add_index "schedule_items", ["project_id", "phase_id"], :name => "index_schedule_items_on_project_id_and_phase_id"

  create_table "services", :force => true do |t|
    t.string   "service_name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "description"
  end

  create_table "shop_drawings", :force => true do |t|
    t.string   "date_received"
    t.integer  "project_id"
    t.integer  "consultant_id"
    t.string   "spec"
    t.string   "letter"
    t.string   "description"
    t.string   "number"
    t.string   "date_sent"
    t.string   "date_returned"
    t.string   "number_sent"
    t.string   "number_returned"
    t.string   "final_action_date"
    t.string   "notes"
    t.string   "review_status"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.string   "final_action"
  end

  add_index "shop_drawings", ["project_id", "consultant_id"], :name => "index_shop_drawings_on_project_id_and_consultant_id"

  create_table "subjects", :force => true do |t|
    t.string   "name"
    t.string   "number"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "tasks", :force => true do |t|
    t.string   "name"
    t.integer  "number"
    t.string   "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "project_id"
  end

  add_index "tasks", ["project_id"], :name => "index_tasks_on_project_id"

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
    t.integer  "phase_number"
    t.integer  "user_id",                                    :null => false
    t.decimal  "total",        :precision => 5, :scale => 2
  end

  add_index "time_entries", ["project_id", "phase_number"], :name => "index_time_entries_on_project_id_and_phase_number"
  add_index "time_entries", ["project_id"], :name => "index_time_entries_on_project_id"
  add_index "time_entries", ["timesheet_id", "project_id", "user_id"], :name => "index_time_entries_on_timesheet_project_and_user"
  add_index "time_entries", ["user_id", "timesheet_id"], :name => "index_time_entries_on_user_id_and_timesheet_id"

  create_table "timesheets", :force => true do |t|
    t.integer  "year",                                                                   :null => false
    t.integer  "week",                                                                   :null => false
    t.datetime "created_at",                                                             :null => false
    t.datetime "updated_at",                                                             :null => false
    t.integer  "selected_year"
    t.boolean  "complete",                                            :default => false
    t.integer  "user_id",                                                                :null => false
    t.text     "notes"
    t.boolean  "printed",                                             :default => false
    t.decimal  "total_hours_saved",     :precision => 5, :scale => 2
    t.decimal  "nb_total_hours_saved",  :precision => 5, :scale => 2
    t.decimal  "timesheet_total_saved", :precision => 5, :scale => 2
    t.decimal  "vacation_hours_saved",  :precision => 5, :scale => 2
  end

  add_index "timesheets", ["user_id", "year", "week"], :name => "index_timesheets_on_user_id_and_year_and_week"
  add_index "timesheets", ["user_id", "year"], :name => "index_timesheets_on_user_id_and_year"
  add_index "timesheets", ["user_id"], :name => "index_timesheets_on_user_id"

  create_table "unassigned_hours", :force => true do |t|
    t.integer  "hours"
    t.integer  "project_id"
    t.integer  "year"
    t.integer  "week"
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
    t.boolean  "active",     :default => true
  end

  add_index "unassigned_hours", ["project_id"], :name => "unassigned_hours_project_id"

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email",              :default => "",    :null => false
    t.datetime "created_at",                            :null => false
    t.datetime "updated_at",                            :null => false
    t.string   "password_digest"
    t.string   "remember_token"
    t.boolean  "admin",              :default => false
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.boolean  "active",             :default => true
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["remember_token"], :name => "index_users_on_remember_token"

  create_table "vacation_records", :force => true do |t|
    t.integer  "user_id"
    t.integer  "year"
    t.decimal  "hours",      :precision => 6, :scale => 2
    t.decimal  "rollover",   :precision => 6, :scale => 2
    t.datetime "created_at",                               :null => false
    t.datetime "updated_at",                               :null => false
  end

  add_index "vacation_records", ["user_id"], :name => "index_vacation_records_on_user_id"

  create_table "vacations", :force => true do |t|
    t.integer  "user_id"
    t.string   "start_date"
    t.string   "end_date"
    t.integer  "hours"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "year"
  end

  add_index "vacations", ["user_id"], :name => "index_vacations_on_user_id"

end
