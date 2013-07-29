class CreateShopDrawings < ActiveRecord::Migration
  def change
    create_table :shop_drawings do |t|
      t.string :date_received
      t.belongs_to :project
      t.belongs_to :consultant
      t.string :spec
      t.string :letter
      t.string :description
      t.string :number
      t.string :date_sent
      t.string :date_returned
      t.string :number_sent
      t.string :number_returned
      t.string :final_action_date
      t.string :notes
      t.string :review_status

      t.timestamps
    end
  end
end
