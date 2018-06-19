class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

	devise :database_authenticatable, :registerable,
	     :recoverable, :rememberable, :trackable, :validatable
	has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/default.png"
	validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/
	validates_with AttachmentSizeValidator, attributes: :avatar, less_than: 10.megabytes
	after_create :welcome_send
	def welcome_send
		WelcomeMailer.welcome_email(self).deliver
	end	
	has_many :votes, dependent: :destroy
end
