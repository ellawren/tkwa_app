module StaticPagesHelper

	def greeting
		if Time.now.hour >= 18
			greeting = "Good Evening."
		elsif Time.now.hour >= 12 
			greeting = "Good Afternoon."
		else
			greeting = "Good Morning."
		end
	end
end
