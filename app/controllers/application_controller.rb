class ApplicationController < ActionController::Base
  # before_action :authenticate_doctor!
  before_action :configure_permitted_parameters, if: :devise_controller?

  include Pundit::Authorization

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def user_not_authorized
    if doctor_signed_in?
      redirect_to dashboard_doctor_path, alert: "You are not authorized to perform this action."
    elsif patient_signed_in?
      redirect_to dashboard_patient_path, alert: "You are not authorized to perform this action."
    else
      redirect_to root_path, alert: "You are not authorized to perform this action."
    end
  end

  def current_user
    Rails.logger.debug "Current doctor: #{current_doctor.inspect}"
    Rails.logger.debug "Current patient: #{current_patient.inspect}"
    @current_user ||= current_doctor || current_patient
  end

  helper_method :current_user
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
