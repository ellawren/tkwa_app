class CreateConsultantReviews < ActiveRecord::Migration
  def change
    create_table :consultant_reviews do |t|
      t.integer :consultant_id
      t.integer :consultant_role_id
      t.string :recommendation

      t.timestamps
    end
  end
end
