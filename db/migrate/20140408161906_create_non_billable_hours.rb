class CreateNonBillableHours < ActiveRecord::Migration
  def change
    create_table :non_billable_hours do |t|
      t.integer :hours
      t.integer :year
      t.integer :week
      t.integer :user_id

      t.timestamps
    end
  end
end
