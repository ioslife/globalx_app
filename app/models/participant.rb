require 'carrierwave/orm/activerecord'

class Participant < ApplicationRecord
  before_save { email.downcase! }
  has_secure_password
  mount_uploader :picture, ParticipantPictureUploader

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :first_name,              presence: true, length: { maximum: 25 }
  validates :last_name,               presence: true, length: { maximum: 25 }
  validates :email,                   presence: true, length: { maximum: 255 }, 
                                            format: { with: VALID_EMAIL_REGEX }, 
                                            uniqueness: { case_sensitive: false }
  validates :phone_number,            presence: true, length: { maximum: 10 }
  validates :address,                 presence: true, length: { maximum: 255 }
  validates :city,                    presence: true, length: { maximum: 255 }
  validates :state,                   presence: true, length: { maximum: 2 }
  validates :zip,                     presence: true, length: { maximum: 5 }
  validates :birthdate,               presence: true
  validates :password,                presence: true, length: { minimum: 6 }

  #returns hash digest of given string
  def Participant.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST:
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
end