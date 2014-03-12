module StaticPagesHelper

	def greeting
		if Time.now.hour < 12
			greeting = "Good Morning."
		elsif Time.now.hour < 18
			greeting = "Good Afternoon."
		else
			greeting = "Good Evening."
		end
	end
end
