class Recommendation < ApplicationRecord
  belongs_to :report
  belongs_to :doctor
end
