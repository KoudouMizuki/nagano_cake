class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  
  
  def after_sign_in_path_for(resource)
    if customer_signed_in?
      root_path
    else admin_signed_in?
      admin_root_path
    end  
  end
  
  def after_sign_out_path_for(resource_or_scope)
    if resource_or_scope == :customer
      root_path
    elsif resource_or_scope == :admin
      admin_session_path
    end
  end  
  
  
  protected
  
  def configure_permitted_parameters
   devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end 
  
end
