class Answer < ApplicationRecord
  belongs_to :patient
  belongs_to :question
  belongs_to :report
end
