class Doctors::RegistrationsController < Devise::RegistrationsController

  def create
    super do |resource|
      if params[:photo]
        resource.photo.attach(params[:photo])
      end
    end
  end

  def update
    super do |resource|
      if params[:photo]
        resource.photo.attach(params[:photo])
      end
    end
  end

  protected

  def after_update_path_for(resource)
    dashboard_doctor_path
  end

  private

  def sign_up_params
    params.require(:doctor).permit(:email, :password, :password_confirmation, :photo, :profession, :location, :first_name, :last_name, :phone_numer, :cedula_profesional, :studies, :curp, :date_birth)
  end

  def account_update_params
    params.require(:doctor).permit(:email, :password, :password_confirmation, :photo, :profession, :location, :first_name, :last_name, :phone_numer, :cedula_profesional, :studies, :curp, :date_birth)
  end
end
