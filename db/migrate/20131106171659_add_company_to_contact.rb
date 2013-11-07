class AddCompanyToContact < ActiveRecord::Migration
  def change
  	add_column :contacts, :work_company, :string
  end
end
