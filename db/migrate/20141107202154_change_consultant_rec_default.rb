class ChangeConsultantRecDefault < ActiveRecord::Migration
  def change
  	change_column :consultants, :recommended, :string, :default => "undecided"
  end
end
