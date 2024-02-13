require 'rqrcode'
class PagesController < ApplicationController
  def home
  end

  def dashboard_doctor
    @doctor = current_doctor
    @contents = Content.where(doctor_id: @doctor.id)
  end

  def dashboard_patient
    @patient = current_patient
    @reports = @patient.reports
    @report = @patient.reports.order(created_at: :desc).first
    @answers = @report.answers if @report
    qr = RQRCode::QRCode.new(shared_url(@patient), size: 4, level: :h)
    @svg = qr.as_svg(offset: 0, color: '000', shape_rendering: 'crispEdges', module_size: 6)
  end
end
