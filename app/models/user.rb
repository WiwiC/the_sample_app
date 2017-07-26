class User < ApplicationRecord
	before_save {self.email = email.downcase}
	validates :name, presence: true, length: {maximum: 50} #permet de valider que le nom e-mail n'est pas vide
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence: true, length: {maximum: 255},
					  format: {with: VALID_EMAIL_REGEX}, #permet de valider que l'email n'est pas vide
					  uniqueness: {case_sensitive: false}
	has_secure_password
	validates :password, presence: true, length: {minimum: 6}
end
