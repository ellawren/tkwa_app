class CreateMonthlyBillings < ActiveRecord::Migration
  def change
    create_table :monthly_billings do |t|
      t.integer :year
      t.integer :month
      t.integer :project_id
      t.decimal :amount, :precision => 8, :scale => 2

      t.timestamps
    end
  end
end
