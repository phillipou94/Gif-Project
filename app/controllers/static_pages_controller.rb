class StaticPagesController < ApplicationController
	def home
		if @selected_channel.nil?
			@gif = get_random_gif
		else
			url_string = "https://api.imgur.com/3/gallery/search?q_any="+@selected_channel+"?q_type=gif/viral"
			@gif = request_with_url(url_string)
		end 
		
		if (!logged_in?)
			render "home"
		else 
			render "dashboard"
		end 
		
	end 

	def get_gif_for_channel
		@selected_channel = params[:channel]
		home

	end 

	def imgur_gif_for_text(text,channel)
		word = get_random_word(text)
		url_string = "https://api.imgur.com/3/gallery/search?q_any="+channel+"+"+word+"?q_type=gif/viral"
		@gif = request_with_url(url_string)
		redirect_to :back

	end 

	def request_with_url(url_string)
		uri = URI(url_string)

		http = Net::HTTP.new(uri.host, uri.port)
		http.use_ssl=true
		request = Net::HTTP::Get.new(uri.request_uri)
		request.add_field("Authorization", "Client-ID 159ef652a6284a9")
		request.add_field("Accept","application/json")
		request.add_field("Content-Type","application/json")
		response = http.request(request)

		results = JSON.parse(response.body)
		dict = results["data"].sample

		gif = Gif.new
		gif.mp4 = dict["mp4"]
		gif.title = dict["title"]
		gif.description = dict["description"]
		gif.url = dict["link"]
		return gif
		#gif.save

		'''render status: 200, json: {
			result: @gif
		}.to_json
		'''
		

	end 

	def get_random_gif()
		url_string = "https://api.imgur.com/3/gallery/search?q_any=funny?q_type=gif/viral"
		gif = request_with_url(url_string)
		return gif
'''
		render status: 200, json: {
			result: gif
		}.to_json
		'''

	end 


	def get_random_word(text)
		tgr = EngTagger.new
		# Add part-of-speech tags to text
		tagged = tgr.add_tags(text)
		nouns = tgr.get_nouns(tagged).keys
		verbs1 = tgr.get_past_tense_verbs(tagged).keys
		verbs2 = tgr.get_infinitive_verbs(tagged).keys

		result = nouns+verbs1+verbs2
		word = result.sample
		return word
	end 
end
