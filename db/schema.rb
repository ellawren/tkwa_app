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

ActiveRecord::Schema.define(:version => 20120224161236) do

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

  create_table "microposts", :force => true do |t|
    t.string   "content"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "microposts", ["user_id", "created_at"], :name => "index_microposts_on_user_id_and_created_at"

  create_table "projects", :force => true do |t|
    t.string   "name"
    t.decimal  "number",              :precision => 8, :scale => 2
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
    t.datetime "created_at",                                        :null => false
    t.datetime "updated_at",                                        :null => false
    t.string   "ext"
    t.string   "contact_ext"
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

  create_table "teams", :force => true do |t|
    t.integer  "project_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "teams", ["project_id", "user_id"], :name => "index_teams_on_project_id_and_user_id", :unique => true
  add_index "teams", ["project_id"], :name => "index_teams_on_project_id"
  add_index "teams", ["user_id"], :name => "index_teams_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.string   "password_digest"
    t.string   "remember_token"
    t.boolean  "admin",           :default => false
    t.integer  "employee_number"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["remember_token"], :name => "index_users_on_remember_token"

end
