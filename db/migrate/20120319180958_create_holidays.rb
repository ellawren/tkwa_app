class CreateHolidays < ActiveRecord::Migration
  def change
    create_table :holidays do |t|
      t.integer :year
      t.date :date
      t.string :name

      t.timestamps
    end
    add_index :holidays, [:date, :year], :unique => true
  end
end
