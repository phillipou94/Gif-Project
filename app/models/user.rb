class User < ActiveRecord::Base
	has_many :images
	has_many :channels
end
