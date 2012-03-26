module HolidaysHelper

	def year_list
		years = []
		Holiday.all.each do |holiday|
			years.push(holiday.date.year)
		end
		unique_items(years).sort_by{ |n| -n.to_i } 

	end


end
