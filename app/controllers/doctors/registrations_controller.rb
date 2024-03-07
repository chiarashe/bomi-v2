class Doctors::RegistrationsController < Devise::RegistrationsController

  def create
    super
  end

  protected

  def after_update_path_for(resource)
    dashboard_doctor_path
  end
end
