class AddMarketingFieldsToProjects < ActiveRecord::Migration
  def change
  	add_column  :projects, :mkt_location, :string
  	add_column  :projects, :mkt_size, :string
  	add_column  :projects, :mkt_cost, :string
  	add_column  :projects, :mkt_description, :string
  	add_column  :projects, :mkt_reference, :string
  end
end
