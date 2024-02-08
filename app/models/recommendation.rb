class Recommendation < ApplicationRecord
  belongs_to :report
  belongs_to :doctor

  has_one_attached :attachment
end
