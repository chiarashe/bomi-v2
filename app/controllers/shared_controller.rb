class SharedController < ApplicationController
  def show
    @patient = current_patient
    @reports = @patient.reports.order(created_at: :desc).limit(5)
    @answers = @reports.map(&:answers).flatten
    @no_count_2 = Answer.where(patient_id: @patient.id, question_id: 2, text: 'No').count
    @si_count_2 = Answer.where(patient_id: @patient.id, question_id: 2, text: 'Sí').count

    @answers_8 = Answer.where(question_id: 8).pluck(:text)
    @answers_9 = Answer.where(question_id: 9).pluck(:text)
    @food_type = Answer.where(patient_id: @patient.id, question_id: 1).pluck(:text) # Assuming question_id 1 is "Tipo de Comida"
    @yes_no = Answer.where(patient_id: @patient.id, question_id: 2).pluck(:text) # Assuming question_id 2 is "Yes/No"

    @data = @yes_no.zip(@food_type).group_by(&:itself).transform_values(&:count)

    @no_count_10 = Answer.where(patient_id: @patient.id, question_id: 2, text: 'No').count
    @si_count_10 = Answer.where(patient_id: @patient.id, question_id: 2, text: 'Sí').count
    @yes_no_10 = Answer.where(patient_id: @patient.id, question_id: 10).pluck(:text)
    @data_10 = @yes_no_10.zip(@food_type).group_by(&:itself).transform_values(&:count)

    @emotion_type = Answer.where(patient_id: @patient.id, question_id: 6).pluck(:text)
    @hunger_type = Answer.where(patient_id: @patient.id, question_id: 8).pluck(:text)
    @data_8 = @hunger_type.zip(@emotion_type).group_by(&:itself).transform_values(&:count)

    @yes_dates = Answer.joins(:report).where(patient_id: @patient.id, question_id: 10, text: "sí").pluck('reports.date')
  end
end
