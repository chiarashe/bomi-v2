class SharedController < ApplicationController
  before_action :authenticate_patient!, only: :show, unless: :doctor_signed_in?
  before_action :authenticate_doctor!, only: :show, unless: :patient_signed_in?

  def show
    @patient = Patient.find(params[:id])
    if patient_signed_in?
      unless current_patient == @patient
        redirect_to dashboard_patient_path, alert: 'You are not authorized to view this page'
        return
      end
    elsif doctor_signed_in?
      @patient = Patient.find(params[:id])
      @doctor = current_doctor
      relation = Relation.find_or_create_by(doctor: @doctor, patient: @patient)
      if relation.persisted?
        Rails.logger.debug "Relation already exists or was created between doctor #{@doctor.id} and patient #{@patient.id}"
      else
        Rails.logger.debug "Failed to create relation between doctor #{@doctor.id} and patient #{@patient.id}"
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
end
