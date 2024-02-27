class Recommendation < ApplicationRecord
  belongs_to :report
  belongs_to :doctor
  belongs_to :patient
  has_one_attached :attachment
end
