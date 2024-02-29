class Patient < ApplicationRecord
  before_create :generate_token
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :relations
  has_many :doctors, through: :relations
  has_many :reports
  has_many :answers, through: :reports
  has_many :recommendations
  has_many :medicines

  private

  def generate_token
    self.token = SecureRandom.urlsafe_base64
  end
end
