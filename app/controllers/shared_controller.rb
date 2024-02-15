class SharedController < ApplicationController
  def show
    @patient = Patient.find(params[:id])
    @doctor = current_doctor
    if @doctor && !Relation.exists?(patient: @patient, doctor: @doctor)
      Relation.create(patient: @patient, doctor: @doctor)
    end
    @reports = @patient.reports.includes(:answers).order(created_at: :desc).limit(5)
    @answers = @reports.map(&:answers).flatten
    answer_counts = Answer.where(patient_id: @patient.id, question_id: 2).group(:text).count
    @no_count = answer_counts['No'] || 0
    @si_count = answer_counts['Sí'] || 0
    meal_counts = Answer.group(:text).count
    @desayuno_count = meal_counts['Desayuno'] || 0
    @almuerzo_count = meal_counts['Almuerzo'] || 0
    @comida_count = meal_counts['Comida'] || 0
    @cena_count = meal_counts['Cena'] || 0
    @answers_8 = Answer.where(question_id: 8).pluck(:text)
    @answers_9 = Answer.where(question_id: 9).pluck(:text)
  end
end
