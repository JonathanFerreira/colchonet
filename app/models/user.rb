class User < ActiveRecord::Base	
	EMAIL_REGEXP = /\A[^@]+@([^@\.]+\.)+[^@\.]+\z/

	#named scopes
	scope :most_recent, -> { order('created_at DESC') }
	scope :from_sampa, -> { where(location: 'São Paulo') }
	scope :confirmed, -> { where.not(confirmed_at: nil) }  

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

    #faz a verificação do email e senha do usuário
	def self.authenticate(email, password)
	  user = confirmed.find_by(email: email)
	  if user.present?
	    user.authenticate(password)
	  end
	end
 #    #igual ao método de cima, porém utilizamos o try
	# def self.authenticate(email, password)
	#   confirmed.find_by(email: email).try(:authenticate, password)
	# end

	private

	def email_format
     errors.add(:email, :invalid) unless email.match(EMAIL_REGEXP)
  	end
end
