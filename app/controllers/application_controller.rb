class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  # Changes to the importmap will invalidate the etag for HTML responses
  stale_when_importmap_changes
  
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
