class SessionsController < ApplicationController
	def new

	end 

	def create
		user = User.find_by(email: params[:session][:email].downcase)
    	if user && user.authenticate(params[:session][:password])
	      # Log the user in and redirect to the user's show page.
	      log_in(user)
	      flash.now[:danger] = 'This is a valid email/password combination'
	    else
	      # Create an error message.
	      flash.now[:danger] = 'Invalid email/password combination'
	    end

	    redirect_to root_url
	end 

	def destroy
		log_out	#method in sessions helper
    	redirect_to root_url
	end 

end
