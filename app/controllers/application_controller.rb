class ApplicationController < ActionController::Base
  # before_action :configure_permitted_parameters, if: :devise_controller?


  # After signing out path
  def after_sign_out_path_for(resource_or_scope)
    flash[:notice] = "You have been signed out"
    static_pages_message_path
  end

  protected

  def configure_permitted_parameters
    # devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :display_name])
    # devise_parameter_sanitizer.permit(:account_update, keys: [:name, :display_name])
  end

end
