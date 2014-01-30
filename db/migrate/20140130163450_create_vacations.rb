class CreateVacations < ActiveRecord::Migration
  def change
    create_table :vacations do |t|
      t.integer :user_id
      t.string :start_date
      t.string :end_date
      t.integer :hours

      t.timestamps
    end
  end
end
