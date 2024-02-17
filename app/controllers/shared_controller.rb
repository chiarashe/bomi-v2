class SharedController < ApplicationController
  def show
    @patient = Patient.find(params[:id])
    @doctor = current_doctor
    if @doctor && !Relation.exists?(patient: @patient, doctor: @doctor)
      Relation.create(patient: @patient, doctor: @doctor)
    end
    @reports = @patient.reports.includes(:answers).order(created_at: :desc).limit(5)
    @answers = @reports.map(&:answers).flatten

    @no_count_2 = Answer.where(patient_id: @patient.id, question_id: 2, text: 'No').count
    @si_count_2 = Answer.where(patient_id: @patient.id, question_id: 2, text: 'Sí').count

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
