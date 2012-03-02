class AddPhaseColumnsToProjects < ActiveRecord::Migration
  def change
  	add_column :projects, :pd_start, :date
  	add_column :projects, :pd_end, :date
  	add_column :projects, :sd_start, :date
  	add_column :projects, :sd_end, :date
  	add_column :projects, :dd_start, :date
  	add_column :projects, :dd_end, :date
  	add_column :projects, :cd_start, :date
  	add_column :projects, :cd_end, :date
  	add_column :projects, :bid_start, :date
  	add_column :projects, :bid_end, :date
  	add_column :projects, :cca_start, :date
  	add_column :projects, :cca_end, :date
  	add_column :projects, :add_start, :date
  	add_column :projects, :add_end, :date

  	add_column :projects, :pd_percent, :integer
  	add_column :projects, :sd_percent, :integer
  	add_column :projects, :dd_percent, :integer
  	add_column :projects, :cd_percent, :integer
  	add_column :projects, :bid_percent, :integer
  	add_column :projects, :cca_percent, :integer
  	add_column :projects, :his_percent, :integer
  	add_column :projects, :int_percent, :integer
  	add_column :projects, :add_percent, :integer
  end
end
