require 'rqrcode'
class PagesController < ApplicationController
  before_action :authenticate_doctor!, only: :dashboard_doctor
  before_action :authenticate_patient!, only: :dashboard_patient
  def home
  end

  def dashboard_doctor
    @doctor = current_doctor
    unless current_doctor == @doctor
      redirect_to root_path, alert: 'Acces denied'
      return
    end
    @contents = Content.where(doctor_id: @doctor.id)
  end

  def dashboard_patient
    @patient = current_patient
    @relation = @patient.relations.find_by(doctor_id: params[:doctor_id])
    unless current_patient == @patient
      redirect_to root_path, alert: 'Acces denied'
      return
    end
    @reports = @patient.reports
    @report = @patient.reports.order(created_at: :desc).first
    @answers = @report.answers if @report
    qr = RQRCode::QRCode.new(shared_url(id: @patient.id, token: @patient.token), size: 6, level: :h)
    @svg = qr.as_svg(offset: 0, color: '000', shape_rendering: 'crispEdges', module_size: 6)
  end
end




# add that the doctor can see the patient's reports with pundit
