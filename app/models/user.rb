class User < ActiveRecord::Base
	has_many :microposts, dependent: :destroy

	before_save { self.email = email.downcase }
	before_create :create_remember_token

	validates :name, presence: true, length: { maximum: 50 }
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(?:\.[a-z\d\-]+)*\.[a-z]+\z/i
	validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, 
					uniqueness: { case_sensitive: false }
	has_secure_password
	validates :password, length: { minimum: 6 }

	# returns a random string of length 16 composed of the characters A–Z, a–z, 0–9, “-”, and “_” 
	def User.new_remember_token
      SecureRandom.urlsafe_base64
  	end

  	# hashes token
	def User.digest(token)
      Digest::SHA1.hexdigest(token.to_s)
	end

  	private

  	  # create token by getting a 16 char random string and then hashing it
      def create_remember_token
      	self.remember_token = User.digest(User.new_remember_token)
      end
end
