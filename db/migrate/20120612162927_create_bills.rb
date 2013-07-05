class CreateBills < ActiveRecord::Migration
  def change
    create_table :bills do |t|
      t.string :date
      t.decimal :amount
      t.integer  :consultant_team_id, :null => false

      t.timestamps
    end
  end
end
