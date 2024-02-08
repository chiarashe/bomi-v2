class PagesController < ApplicationController
  def home
  end

  def dashboard_doctor
    @doctor = current_doctor
  end

  def dashboard_patient
    @patient = current_patient
    @reports = @patient.reports
    @answers = @reports.map { |report| report.answers }.flatten
  end
end
