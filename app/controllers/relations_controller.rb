class RelationsController < ApplicationController
  before_action :set_relation, only: %i[destroy update_status]

  def destroy
    @relation.destroy
    redirect_to dashboard_patient_path, notice: 'Relation was successfully deleted.'
  end

  def update_status
    @relation.update(status: params[:status])
    @patient = Patient.find(@relation.patient_id)

    redirect_to(appropriate_path, notice: 'Status was successfully updated.') if current_user.is_a?(Doctor)
  end

  private

  def set_relation
    @relation = Relation.find(params[:id])
  end

  def appropriate_path
    case @relation.status
    when 'pending', 'denied'
      dashboard_doctor_path
    when 'confirmed'
      shared_path(id: @patient.id, token: @patient.token)
    end
  end
end
