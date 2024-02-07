class PagesController < ApplicationController
  def home
  end

  def dashboard_doctor
    @doctor = current_doctor
    @contents = Content.where(doctor_id: @doctor.id)
  end

  def dashboard_patient
    @patient = current_patient
  end
end
