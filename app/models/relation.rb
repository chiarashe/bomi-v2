class Relation < ApplicationRecord
  belongs_to :patient
  belongs_to :doctor

  enum status: { pending: 'pending', confirmed: 'confirmed', denied: 'denied' }
end
