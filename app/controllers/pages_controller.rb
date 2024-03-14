require 'rqrcode'
class PagesController < ApplicationController
  before_action :authenticate_doctor!, only: :dashboard_doctor
  before_action :authenticate_patient!, only: :dashboard_patient
  before_action :set_patient, only: :dashboard_patient
  before_action :set_doctor, only: :dashboard_doctor
  before_action :set_qr_code, only: :dashboard_patient

  def dashboard_doctor
    @contents = Content.where(doctor_id: @doctor.id)
  end

  def dashboard_patient
    @medicine = Medicine.new
    @relation = @patient.relations.find_by(doctor_id: params[:doctor_id])
    @reports = @patient.reports
    @report = latest_report
    if @report.nil?
      flash.now[:alert] = 'No report found yet'
      return
    end
    @answers = @report.answers if @report
  end

  private

  def set_patient
    @patient = current_patient
  end

  def set_doctor
    @doctor = current_doctor
  end

  def check_patient
    redirect_to(root_path, alert: 'Access denied') unless current_patient
  end

  def check_doctor
    redirect_to(root_path, alert: 'Access denied') unless current_doctor
  end

  def latest_report
    @patient.reports.order(created_at: :desc).first
  end

  def set_qr_code
    qr = RQRCode::QRCode.new(shared_url(id: @patient.id, token: @patient.token), size: 6, level: :h)
    @svg = qr.as_svg(offset: 0, color: '000', shape_rendering: 'crispEdges', module_size: 6)
  end
end
