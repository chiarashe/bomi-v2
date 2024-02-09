class Doctors::RegistrationsController < Devise::RegistrationsController

  protected

  def after_update_path_for(resource)
    dashboard_doctor_path
  end
end
