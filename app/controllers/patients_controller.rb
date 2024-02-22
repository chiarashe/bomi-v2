class PatientsController < ApplicationController
  before_action :authenticate_patient!

  def show
    @patient = Patient.find(params[:id])
    @qr = RQRCode::QRCode.new(patient_url(@patient), size: 4, level: :h)
  end
end
