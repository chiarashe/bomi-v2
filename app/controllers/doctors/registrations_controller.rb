class Doctors::RegistrationsController < Devise::RegistrationsController

  def create
    super do |resource|
      if resource.persisted?
        sign_in(resource)
      end
    end
  end

  protected

  def after_update_path_for(resource)
    dashboard_doctor_path
  end
end
