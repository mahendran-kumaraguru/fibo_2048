class User < ActiveRecord::Base
	has_many :games
	attr_accessor :password

	before_save :encrypt_password

	validates_presence_of :email
	validates_presence_of :password, :on => :create
	validates_confirmation_of :password
	validates_uniqueness_of :email

	def self.authenticate(email, password)
		user = User.find_by(:email=>email)
		if user and user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
			user
		else
			nil
		end
	end

	def self.user_signed_in?
		user = User.find(session[:user_id])
		if user
			:true
		else
			:false
		end
	end


	def encrypt_password
		if password.present?
			puts "encrypting password"
			self.password_salt = BCrypt::Engine.generate_salt
			self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
		end
	end
end
