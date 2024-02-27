class AddPatientToRecommendations < ActiveRecord::Migration[7.1]
  def change
    add_reference :recommendations, :patient, null: false, foreign_key: true
  end
end
