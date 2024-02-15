class SharedController < ApplicationController
  def show
    @patient = current_patient
    @reports = @patient.reports.order(created_at: :desc).limit(5)
    @answers = @reports.map(&:answers).flatten
    @no_count = Answer.where(patient_id: @patient.id, question_id: 2, text: 'No').count
    @si_count = Answer.where(patient_id: @patient.id, question_id: 2, text: 'Sí').count
    @desayuno_count = Answer.where(text: 'Desayuno').count
    @almuerzo_count = Answer.where(text: 'Almuerzo').count
    @comida_count = Answer.where(text: 'Comida').count
    @cena_count = Answer.where(text: 'Cena').count
    @answers_8 = Answer.where(question_id: 8).pluck(:text)
    @answers_9 = Answer.where(question_id: 9).pluck(:text)
  end
end
