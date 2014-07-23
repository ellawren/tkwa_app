class CreatePatternImages < ActiveRecord::Migration
  def change
    create_table :pattern_images do |t|

    	t.attachment :photo
    	t.integer :pattern_id
      	t.timestamps

    end
  end
end
