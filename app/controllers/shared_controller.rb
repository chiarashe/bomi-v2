class SharedController < ApplicationController
  def show
    @patient = Patient.find(params[:id])
    @doctor = current_doctor
    if @doctor && !Relation.exists?(patient: @patient, doctor: @doctor)
      Relation.create(patient: @patient, doctor: @doctor)
    end
    @reports = @patient.reports.includes(:answers).order(created_at: :desc).limit(5)
    @answers = @reports.map(&:answers).flatten

#filter
    start_date = params[:start_date].present? ? Date.parse(params[:start_date]) : nil
    end_date = params[:end_date].present? ? Date.parse(params[:end_date]) : nil
    @answers = Answer.joins(:report).where(patient_id: @patient.id)
    @answers = @answers.where('reports.date >= ?', start_date) if start_date
    @answers = @answers.where('reports.date <= ?', end_date) if end_date

#pie chart yes/no alimentarte
    @no_count_2 = @answers.where(question_id: 2, text: "No").count
    @si_count_2 = @answers.where(question_id: 2, text: "Sí").count

#bar chart alimentarte vs tipo de comida
    answer_counts = @answers.where(patient_id: @patient.id, question_id: 2).group(:text).count
    @no_count = answer_counts['No'] || 0
    @si_count = answer_counts['Sí'] || 0
    meal_counts = @answers.group(:text).count
    @desayuno_count = meal_counts['Desayuno'] || 0
    @almuerzo_count = meal_counts['Almuerzo'] || 0
    @comida_count = meal_counts['Comida'] || 0
    @cena_count = meal_counts['Cena'] || 0

    @answers_8 = @answers.where(question_id: 8).pluck(:text)
    @answers_9 = @answers.where(question_id: 9).pluck(:text)
    @food_type = @answers.where(question_id: 1).pluck(:text) # Assuming question_id 1 is "Tipo de Comida"
    @yes_no = @answers.where(question_id: 2).pluck(:text) # Assuming question_id 2 is "Yes/No"# Assuming question_id 2 is "Yes/No"

    @data = @yes_no.zip(@food_type).group_by(&:itself).transform_values(&:count)

    @no_count_10 = @answers.where(patient_id: @patient.id, question_id: 10, text: 'No').count
    @si_count_10 = @answers.where(patient_id: @patient.id, question_id: 10, text: 'Sí').count


    @yes_no_10 = @answers.where(patient_id: @patient.id, question_id: 10).pluck(:text)
    @data_10 = @yes_no_10.zip(@food_type).group_by(&:itself).transform_values(&:count)

    @emotion_type = @answers.where(patient_id: @patient.id, question_id: 6).pluck(:text)
    @hunger_type = @answers.where(patient_id: @patient.id, question_id: 8).pluck(:text)
    @data_8 = @hunger_type.zip(@emotion_type).group_by(&:itself).transform_values(&:count)

  #red flags/green flags
    @yes_dates_atracon = Answer.joins(:report).where(patient_id: @patient.id, question_id: 10, text: "Sí").pluck('reports.date')
    @no_dates_alimentacion = Answer.joins(:report).where(patient_id: @patient.id, question_id: 2, text: "No").pluck('reports.date')
    @no_dates_recomendacion = Answer.joins(:report).where(patient_id: @patient.id, question_id: 4, text: "No").pluck('reports.date')
    @emociones_positivas = Answer.joins(:report).where(patient_id: @patient.id, question_id: 6, text: "5").pluck('reports.date')
  end
end
