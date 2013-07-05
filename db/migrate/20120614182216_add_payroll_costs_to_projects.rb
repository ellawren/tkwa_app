class AddPayrollCostsToProjects < ActiveRecord::Migration
  def change
  	add_column  :projects, :payroll, :decimal, :precision => 12, :scale => 2
  end
end
