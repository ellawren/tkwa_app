class RemoveCompanyMentions < ActiveRecord::Migration
  def change
  	remove_column :contacts, :company_id
  end
end
