class TimeEntriesController < ApplicationController
	def edit
    	@time_entry = TimeEntry.find(params[:id])
    end
end