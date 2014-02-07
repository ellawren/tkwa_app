class UserMailer < ActionMailer::Base
  	default from: "from@example.com"

  	def welcome_email(user)
	    @user = user
	    @url  = 'http://db.tkwa.com'
	    mail(to: @user.email, subject: 'Welcome to the TKWA Database')
  	end
end
