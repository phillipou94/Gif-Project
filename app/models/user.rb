class User < ActiveRecord::Base
	has_many :gifs
	has_many :channels
	
	attr_accessor :password, :password_confirmation #allow these attributes to be accessible
	EMAIL_REGEX = /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
	validates :email, presence: true
	validates :name, presence: true
	validates :email, uniqueness: true, :format => EMAIL_REGEX, if: 'email.present?'
	validates :password, length: { minimum: 6 }
	before_save :encrypt_password
	after_save :clear_password
	validate :passwords_equal

	def authenticate(password)
	    return self.encrypted_password == BCrypt::Engine.hash_secret(password, self.salt)
	end 

	def passwords_equal
		return :password == :password_confirmation
	end 

	''' Password Encryption '''
	def encrypt_password
	  if password.present?
	    self.salt = BCrypt::Engine.generate_salt
	    self.encrypted_password= BCrypt::Engine.hash_secret(password, self.salt)
	  end
	end

	def clear_password
	  self.password = nil
	end

	
end
