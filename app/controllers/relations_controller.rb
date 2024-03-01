class RelationsController < ApplicationController
  def destroy
    @relation = Relation.find(params[:id])
    @relation.destroy
    redirect_to dashboard_patient_path, notice: 'Relation was successfully deleted.'
  end

  def update_status
    @relation = Relation.find(params[:id])
    @relation.update(status: params[:status])
    @patient = Patient.find(@relation.patient_id)

    if current_user.is_a?(Doctor)
      if @relation.status == 'denied'
      redirect_to dashboard_doctor_path, notice: 'Relation was successfully denied.'
      elsif @relation.status == 'confirmed'
        redirect_to shared_path(id: @patient.id, token: @patient.token), notice: 'Relation was successfully confirmed.'
      else
        redirect_to dashboard_doctor_path, notice: 'Wait for the patient to confirm the relation.'
      end
    end
  end
end
