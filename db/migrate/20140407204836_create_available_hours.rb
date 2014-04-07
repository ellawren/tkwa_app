class CreateAvailableHours < ActiveRecord::Migration
  def change
    create_table :available_hours do |t|
      t.integer :hours
      t.integer :user_id
      t.integer :year
      t.integer :week

      t.timestamps
    end
  end
end
