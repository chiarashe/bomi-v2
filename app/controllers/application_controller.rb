class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :phone_number, :location, :goal, :profession, :curp, :cedula_profesional, :studies])
    devise_parameter_sanitizer.permit(:account_update, keys: [:phone_number, :profession, :location, :goal])
  end

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
