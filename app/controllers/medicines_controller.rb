class MedicinesController < ApplicationController
  def create
    @medicine = Medicine.new(medicine_params)
    @patient = current_patient
    @medicine.patient = @patient
    authorize @medicine
    if @medicine.save
      redirect_to dashboard_patient_path, notice: 'Medicine was successfully added.'
    else
      redirect_to dashboard_patient_path, alert: 'Medicine was not added. Try again.'
    end
  end

  def destroy
    @medicine = Medicine.find(params[:id])
    authorize @medicine
    @medicine.destroy
    redirect_to dashboard_patient_path, notice: 'Medicine was successfully deleted.'
  end

  private

  def medicine_params
    params.require(:medicine).permit(:name, :dosage, :times_a_day, :duration, :start_date, :end_date, :recommended_by, :patient_id)
  end
end
