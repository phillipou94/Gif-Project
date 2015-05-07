
class UsersController < ApplicationController
	def new
		@user = User.new
	end 
	def signup
		@user = User.new(user_params)
		@user.gifs_seen = 0
		if @user.save
			log_in @user	
		else
			 @user.errors.full_messages.each do |msg|
      			flash[:danger] = "Login Failed: "+msg
      		end 
		end 
		redirect_to root_url
		
	end 

	private

    def user_params
      params.require(:user).permit(:email, :name,:password, :password_confirmation)
                                   
    end

end
