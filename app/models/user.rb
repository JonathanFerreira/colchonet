class User < ActiveRecord::Base
	EMAIL_REGEXP = /\A[^@]+@([^@\.]+\.)+[^@\.]+\z/

	validates_presence_of :email, :full_name, :location, :password_digest
	validates_length_of :bio, minimum: 30, allow_blank: false
	validates_uniqueness_of :email

	validate :email_format

	has_secure_password

	before_create do |user|
	  user.confirmation_token = SecureRandom.urlsafe_base64
	end
    #marca a hora e data da confirmação e limpa o token, permitindo apenas uma unica confirmação. 
	def confirm!
	  return if confirmed?
	
	  self.confirmed_at = Time.current
	  self.confirmation_token = ''
	  save!
	end
	
	# verifica se o usuário já esta confirmado. 
	def confirmed?
	  confirmed_at.present?
	end

	private

	def email_format
     errors.add(:email, :invalid) unless email.match(EMAIL_REGEXP)
  	end
end
