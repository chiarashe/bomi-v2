class RelationsController < ApplicationController
  def destroy
    @relation = Relation.find(params[:id])
    @relation.destroy
    redirect_to dashboard_patient_path, notice: 'Relation was successfully deleted.'
  end
end
