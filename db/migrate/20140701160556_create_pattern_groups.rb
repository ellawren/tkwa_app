class CreatePatternGroups < ActiveRecord::Migration
  def change
    create_table :pattern_groups do |t|
      t.string :name

      t.timestamps
    end
  end
end
