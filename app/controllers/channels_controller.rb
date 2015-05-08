class ChannelsController < ApplicationController
	def create
		channel = Channel.new(:name => params[:channel][:name])
		user = current_user()
		channel.user_id = user.id
		channel.save
		@selected_channel = channel.name
		redirect_to root_path
	end

	def destroy
		channel=Channel.find_by(id:params[:channel_id])
		channel.destroy
		redirect_to root_path

	end 

end
