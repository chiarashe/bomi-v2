class ChangePatientIdInAnswers < ActiveRecord::Migration[7.1]
  def change
    change_column_null :answers, :patient_id, true
  end
end
