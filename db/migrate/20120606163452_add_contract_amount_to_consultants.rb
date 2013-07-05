class AddContractAmountToConsultants < ActiveRecord::Migration
  def change
  	add_column :consultant_teams, :consultant_contract, :decimal, :precision => 12, :scale => 2
  end
end
