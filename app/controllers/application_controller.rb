class ApplicationController < ActionController::Base

  protected

  def after_sign_in_path_for(resource)
    if resource.is_a?(Doctor)
      dashboard_doctor_path
    elsif resource.is_a?(Patient)
      dashboard_patient_path
    else
      super
    end
  end
end
