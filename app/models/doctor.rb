class Doctor < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :relations
  has_many :patients, through: :relations
  has_many :contents
  has_many :recommendations
  has_one_attached :photo

  PROFESSION = %w[Medico Nutriólogo Nutricionista Psicólogo Psiquiatra Otro]
end
