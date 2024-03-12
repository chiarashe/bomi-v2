class Answer < ApplicationRecord
  has_many :answer_options
  accepts_nested_attributes_for :answer_options
  belongs_to :patient, optional: true
  belongs_to :question
  belongs_to :report
end
