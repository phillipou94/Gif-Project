class User < ActiveRecord::Base
	has_many :gifs
	has_many :channels
end
