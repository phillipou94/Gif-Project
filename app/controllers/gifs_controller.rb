require 'rubygems'
require 'engtagger'
class GifsController < ApplicationController

	def imgur_gif_for_text(text,channel)
		word = get_random_word(text)

		url_string = "https://api.imgur.com/3/gallery/search?q_any="+channel+"+"+word+"?q_type=gif/viral"
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
		#gif.save

		render status: 200, json: {
			random:word,
			result: gif
		}.to_json

	end 

	def get_random_gif()
		gif = Gif.order("RANDOM()").first
		render status: 200, json: {
			result: gif
		}.to_json

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
'''
	def giphy_gif_for_text(text)
		word = get_random_word(text)
		url_string = "http://api.giphy.com/v1/gifs/search?q="+word+"&api_key=dc6zaTOxFJmzC"
		uri = URI(url_string)

		http = Net::HTTP.new(uri.host, uri.port)
		request = Net::HTTP::Get.new(uri.request_uri)
		response = http.request(request)

		results = JSON.parse(response.body)
		gif = results["data"].sample
		versions = gif["images"]
		description = gif["caption"]
		mp4 = versions["original"]["mp4"]

		render status: 200, json: {
			gif: results,
			random:word,
			description: description,
			mp4:mp4
		}.to_json

	end 
'''

end
