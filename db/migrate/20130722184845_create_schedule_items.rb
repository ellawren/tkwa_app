class CreateScheduleItems < ActiveRecord::Migration
  def change
    create_table :schedule_items do |t|
      t.belongs_to :project
      t.belongs_to :phase
      t.string :desc
      t.string :start
      t.string :end

      t.timestamps
    end
  end
end
