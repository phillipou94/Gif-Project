class ChannelsController < ApplicationController
	def create
		channel = Channel.new(:name => params[:channel][:name])
		user = current_user()
		channel.user_id = user.id
		channel.save
		redirect_to root_path
	end

end
