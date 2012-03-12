class CreatePhases < ActiveRecord::Migration
  def change
    create_table :phases do |t|
      t.string :name
      t.integer :number
      t.string :shorthand

      t.timestamps
    end
  end
end
