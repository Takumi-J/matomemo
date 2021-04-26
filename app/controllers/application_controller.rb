class ApplicationController < ActionController::Base
    before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys:
    [:name,:opinion])
  end

  def after_sign_in_path_for(resource)
    case resource
    when Admin
      admin_works_path
    when Member
      root_path
    end
  end

end
