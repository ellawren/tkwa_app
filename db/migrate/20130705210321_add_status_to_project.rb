class AddStatusToProject < ActiveRecord::Migration
  def change
  	add_column  :projects, :mkt_status, :string
  end
end
