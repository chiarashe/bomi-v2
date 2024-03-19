class MedicinesController < ApplicationController
  before_action :set_medicine, only: [:destroy]

  def new
    @medicine = Medicine.new
  end

  def create
    @medicine = Medicine.new(medicine_params)
    @medicine.patient = current_patient
    authorize @medicine
    if @medicine.save
      redirect_to dashboard_patient_path, notice: 'Medicine was successfully added.'
    else
      redirect_to dashboard_patient_path, alert: 'Medicine was not added. Try again.'
    end
  end


  def destroy
    authorize @medicine
    if @medicine.destroy
      redirect_to dashboard_patient_path, notice: 'Medicine was successfully deleted.'
    else
      redirect_to dashboard_patient_path, alert: 'Medicine was not deleted. Try again.'
    end
  end

  private

  def set_medicine
    @medicine = Medicine.find(params[:id])
  end

  def medicine_params
    params.require(:medicine).permit(
      :name, :dosage, :times_a_day, :duration,
      :start_date, :end_date, :recommended_by, :patient_id
    )
  end
end
