class CreateBillingTypes < ActiveRecord::Migration
  def change
    create_table :billing_types do |t|
      t.string :name

      t.timestamps
    end
  end
end
