class Answer < ApplicationRecord
  belongs_to :patient, optional: true
  belongs_to :question
  belongs_to :report
end
