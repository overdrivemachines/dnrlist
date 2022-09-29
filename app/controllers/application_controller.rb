class ApplicationController < ActionController::Base
  # After signing out path
  def after_sign_out_path_for(resource_or_scope)
    flash[:notice] = "You have been signed out"
    static_pages_message_path
  end
end
