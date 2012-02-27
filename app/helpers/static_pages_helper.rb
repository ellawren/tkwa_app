module StaticPagesHelper

	def greeting
		if Time.now.hour >= 12
			greeting = "Good Evening."
		elsif Time.now.hour >= 6 
			greeting = "Good Afternoon."
		else
			greeting = "Good Morning."
		end
	end
end
