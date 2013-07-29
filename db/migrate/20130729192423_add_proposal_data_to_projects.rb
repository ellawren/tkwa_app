class AddProposalDataToProjects < ActiveRecord::Migration
  def change
  	add_column :projects, :proposal_date, :string
  	add_column :projects, :interview_date, :string
  	add_column :projects, :awarded, :string, default: "pending"
  end
end
