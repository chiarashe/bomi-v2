class Patients::RegistrationsController < Devise::RegistrationsController

  protected

  def after_update_path_for(resource)
    dashboard_patient_path
  end
end
