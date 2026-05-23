class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]

  def new
    build_resource({})
    respond_with resource do |format|
      if request.path == new_user_path
        format.html { render "users/registrations/new" }
      else
        format.html { render "devise/registrations/new" }
      end
    end
  end

  def create
    build_resource(sign_up_params)

    resource.save
    yield resource if block_given?
    if resource.persisted?
      if resource.active_for_authentication?
        set_flash_message! :notice, :signed_up
        sign_up(resource_name, resource)
        respond_with resource, location: after_sign_up_path_for(resource)
      else
        set_flash_message! :notice, "signed_up_but_#{resource.inactive_message}"
        expire_data_after_sign_in!
        respond_with resource, location: after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      set_minimum_password_length
      if sign_up_params[:email_address].present? || request.path == new_user_path
        render "users/registrations/new"
      else
        render "devise/registrations/new"
      end
    end
  end

  protected

  def after_sign_up_path_for(resource)
    user_path(resource)
  end

  def after_inactive_sign_up_path_for(resource)
    user_path(resource)
  end

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email, :email_address])
  end
end
