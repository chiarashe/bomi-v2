class SharedController < ApplicationController
  before_action :set_patient
  before_action :authenticate_user!

  def show
    Rails.logger.debug "Current user: #{current_user}"
    Rails.logger.debug "Doctor signed in: #{doctor_signed_in?}"
    Rails.logger.debug "Patient signed in: #{patient_signed_in?}"
    
    if patient_signed_in?
      unless current_patient == @patient
        redirect_to dashboard_patient_path, alert: 'You are not authorized to view this page'
        return
      end
    elsif doctor_signed_in?
      @doctor = current_doctor
      relation = Relation.find_or_create_by(doctor: @doctor, patient: @patient)
      if relation.persisted?
        Rails.logger.debug "Relation already exists or was created between doctor #{@doctor.id} and patient #{@patient.id}"
      else
        Rails.logger.debug "Failed to create relation between doctor #{@doctor.id} and patient #{@patient.id}"
        Rails.logger.debug "Validation errors: #{relation.errors.full_messages}"
      end
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

  private

  def set_patient
    @patient = Patient.find(params[:id])
  end

  def authenticate_user!
    if doctor_signed_in?
      authenticate_doctor!
    elsif patient_signed_in?
      authenticate_patient!
    else
      redirect_to new_user_session_path, alert: 'You need to sign in or sign up before continuing'
    end
  end
end
