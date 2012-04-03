class CreateGlobals < ActiveRecord::Migration
  def change
    create_table :globals do |t|
      t.integer :year
      t.decimal :multipler, :precision => 4, :scale => 2
      t.decimal :mileage, :precision => 4, :scale => 2

      t.timestamps
    end
  end
end
