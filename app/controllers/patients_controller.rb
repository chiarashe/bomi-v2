class PatientsController < ApplicationController
  before_action :authenticate_patient!
  before_action :set_patient, only: :show

  def show
    @qr = RQRCode::QRCode.new(patient_url(@patient), size: 4, level: :h)
  end

  private

  def set_patient
    @patient = current_patient
  end
end
