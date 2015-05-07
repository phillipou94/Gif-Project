
class UsersController < ApplicationController

	def signup
		user = User.new(user_params)
		if user.save
			log_in user
			
		end 

		redirect_to root_url

	end 

	private

    def user_params
      params.require(:user).permit(:email, :name,:password, :password_confirmation)
                                   
    end

end
