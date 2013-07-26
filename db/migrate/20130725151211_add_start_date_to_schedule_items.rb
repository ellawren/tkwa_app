class AddStartDateToScheduleItems < ActiveRecord::Migration
  def change
  	add_column :schedule_items, :start_date, :date
  end
end
