class Report < ApplicationRecord
  belongs_to :patient
  has_many :questions
  has_many :recommendations
end
