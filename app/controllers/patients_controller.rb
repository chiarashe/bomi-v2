class PatientsController < ApplicationController
  def show
    @patient = Patient.find(params[:id])
    @qr = RQRCode::QRCode.new(patient_url(@patient), size: 4, level: :h)
  end
end
