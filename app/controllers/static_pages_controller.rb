class StaticPagesController < ApplicationController
	def home
		if (!logged_in?)
			render "home"
		else 
			render "dashboard"
		end 
	end 
end
