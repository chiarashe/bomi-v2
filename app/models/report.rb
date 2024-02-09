class Report < ApplicationRecord
  belongs_to :patient
  has_many :answers
  has_many :recommendations
  accepts_nested_attributes_for :answers
end
