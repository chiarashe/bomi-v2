class SharedController < ApplicationController
  before_action :set_patient
  before_action :authenticate_user!

  def show

    #report table with filter
    @patient = Patient.find(params[:id])
    if params[:start_date].present? && params[:end_date].present?
      start_date = Date.parse(params[:start_date])
      end_date = Date.parse(params[:end_date])
      @reports = @patient.reports.where(created_at: start_date.beginning_of_day..end_date.end_of_day)
    else
      @reports = @patient.reports
    end
    @questions = Question.all
    @answers_by_report = @reports.map do |report|
      { report: report, answers: report.answers }
    end

    @shared_url = generate_shared_url(@patient)
    @report = Report.find(params[:id])
    @doctors = @patient.doctors
    @recommendations = Recommendation.where(doctor: current_doctor, patient: @patient, report: @report)
    @recommendation = Recommendation.find_by(report: @report)

    if patient_signed_in?
      unless current_patient == @patient
        redirect_to dashboard_patient_path, alert: 'You are not authorized to view this page'
        return
      end
    elsif doctor_signed_in?
      Rails.logger.info "Is doctor signed in? #{doctor_signed_in?}"
      @doctor = current_doctor
      relation = Relation.find_or_create_by(doctor: @doctor, patient: @patient)
      unless relation.confirmed?
        redirect_to dashboard_doctor_path, alert: 'You are not authorized to view this page'
        return
      end
    end

    @reports = @patient.reports.includes(:answers).order(created_at: :desc).limit(5)
    @answers = @reports.map(&:answers).flatten
    @reports_all = Report.where(patient_id: @patient.id)

#filter
    start_date = params[:start_date].present? ? Date.parse(params[:start_date]) : nil
    end_date = params[:end_date].present? ? Date.parse(params[:end_date]) : nil
    @answers = Answer.joins(:report).where(patient_id: @patient.id)
    @answers = @answers.where('reports.date >= ?', start_date) if start_date
    @answers = @answers.where('reports.date <= ?', end_date) if end_date

#pie chart yes/no descontrol
    answers = @answers.where(question_id: 7)
    @no_count_7 = answers.where(text: 'No').count
    @si_count_7 = answers.where(text: 'Sí').count

#pie chart yes/no balance
    answers = @answers.where(question_id: 8)
    @no_count_8 = answers.where(text: 'No').count
    @si_count_8 = answers.where(text: 'Sí').count

#pie chart emotions
    # Fetch answers for question id 1 within the date range
    answers = @answers.where(question_id: 1)
    answers = answers.where('answers.created_at >= ?', start_date) if start_date
    answers = answers.where('answers.created_at <= ?', end_date) if end_date

    # Split text (emotion) of each answer into individual emotions and count them
    emotion_counts = Hash.new(0)
    answers.each do |answer|
      emotions = answer.text.downcase.split(', ')
      emotions.each { |emotion| emotion_counts[emotion] += 1 }
    end

    @emotion_counts = emotion_counts

    # Count the number of times the answer was "Enojado"
    @enojado_count = emotion_counts['enojado']

    # Fetch answers for question id 9 within the date range
    @answers_9 = Answer.where(question_id: 9)
    @answers_9 = @answers_9.where('created_at >= ?', start_date) if start_date
    @answers_9 = @answers_9.where('created_at <= ?', end_date) if end_date


    # Fetch answers for question id 10 within the date range
    @answers_10 = Answer.where(question_id: 10)

  #alimentarte
    # Fetch answers for question id 3 within the date range
    answers_3 = @answers.where(question_id: 3)
    answers_3 = answers_3.where('answers.created_at >= ?', start_date) if start_date
    answers_3 = answers_3.where('answers.created_at <= ?', end_date) if end_date

    # Count the number of times the answer was "Sí"
    @si_count_3 = answers_3.where(text: 'Sí').count

  #number of yes of balance
    # Fetch answers for question id 3 within the date range
    answers_8 = @answers.where(question_id: 8)
    answers_8 = answers_8.where('answers.created_at >= ?', start_date) if start_date
    answers_8 = answers_8.where('answers.created_at <= ?', end_date) if end_date

    # Count the number of times the answer was "Sí"
    @si_count_8 = answers_8.where(text: 'Sí').count
    @yes_dates_question_8 = Answer.joins(:report).where(patient_id: @patient.id, question_id: 8, text: "Sí").pluck('reports.date')

  #scatter chart
    # Fetch answers for question id 9 and 10
    answers_9 = @answers.where(question_id: 9)
    answers_10 = @answers.where(question_id: 10)

    # Create an array of arrays, where each sub-array represents a point and contains two values: the value of answer id 9 and the value of answer id 10
    @scatter_data = answers_9.zip(answers_10).map { |a, b| [a.text.to_i, b.text.to_i] }


  #bar chart alimentarte vs tipo de comida
    answer_counts = @answers.where(patient_id: @patient.id, question_id: 2).group(:text).count
    @no_count = answer_counts['No'] || 0
    @si_count = answer_counts['Sí'] || 0
    meal_counts = @answers.group(:text).count
    @desayuno_count = meal_counts['Desayuno'] || 0
    @almuerzo_count = meal_counts['Almuerzo'] || 0
    @comida_count = meal_counts['Comida'] || 0
    @cena_count = meal_counts['Cena'] || 0



    @food_type = @answers.where(question_id: 1).pluck(:text) # Assuming question_id 1 is "Tipo de Comida"
    @yes_no = @answers.where(question_id: 2).pluck(:text) # Assuming question_id 2 is "Yes/No"# Assuming question_id 2 is "Yes/No"

    @data = @yes_no.zip(@food_type).group_by(&:itself).transform_values(&:count)

    @no_count_10 = @answers.where(patient_id: @patient.id, question_id: 10, text: 'No').count
    @si_count_10 = @answers.where(patient_id: @patient.id, question_id: 10, text: 'Sí').count




    @emotion_type = @answers.where(patient_id: @patient.id, question_id: 6).pluck(:text)
    @hunger_type = @answers.where(patient_id: @patient.id, question_id: 8).pluck(:text)
    @data_8 = @hunger_type.zip(@emotion_type).group_by(&:itself).transform_values(&:count)


    start_date = params[:start_date].present? ? Date.parse(params[:start_date]) : nil
    end_date = params[:end_date].present? ? Date.parse(params[:end_date]) : nil

    @no_dates_alimentacion = Answer.joins(:report).where(patient_id: @patient.id, question_id: 2, text: "No").pluck('reports.date')
    @no_dates_recomendacion = Answer.joins(:report).where(patient_id: @patient.id, question_id: 4, text: "No").pluck('reports.date')
    @emociones_positivas = Answer.joins(:report).where(patient_id: @patient.id, question_id: 6, text: "5").pluck('reports.date')

    @no_dates_recomendacion.select! do |date|
      (start_date.nil? || date >= start_date) && (end_date.nil? || date <= end_date)
    end

  #red flags/green flags
    @yes_dates_atracon = Answer.joins(:report).where(patient_id: @patient.id, question_id: 7, text: "Sí").pluck('reports.date')
    @no_dates_alimentacion = Answer.joins(:report).where(patient_id: @patient.id, question_id: 2, text: "No").pluck('reports.date')
    @no_dates_recomendacion = Answer.joins(:report).where(patient_id: @patient.id, question_id: 4, text: "No").pluck('reports.date')
    @emociones_positivas = Answer.joins(:report).where(patient_id: @patient.id, question_id: 6, text: "5").pluck('reports.date')
  end
  private

  def authenticate_user!
    if patient_signed_in?
      authenticate_patient!
    elsif doctor_signed_in?
      authenticate_doctor!
    else
      redirect_to dashboard_doctor_path, alert: 'You still not have access to this page'
    end
  end

  def authenticate_doctor!
    Rails.logger.debug "Doctor signed in? #{doctor_signed_in?}"
    unless doctor_signed_in?
      Rails.logger.info "Redirecting to new doctor session path"
      redirect_to new_doctor_session_path, alert: 'You need to sign in or sign up before continuing'
    end
  end

  def generate_shared_url(patient)
    if patient.token
    Rails.application.routes.url_helpers.shared_url(id: patient.id, token: patient.token, host: 'localhost', port: 3000)
    else
      raise "Patient #{patient.id} does not have a token. Please run `rails db:migrate` to add the token column to the patients table."
    end
  end

  def set_patient
    @patient = Patient.find(params[:id])
  end

  def set_doctor
    @doctor = Doctor.find(params[:id])
  end

end
