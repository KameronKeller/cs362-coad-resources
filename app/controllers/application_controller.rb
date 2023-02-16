class ApplicationController < ActionController::Base

  def after_sign_in_path_for(resource)
    dashboard_path
  end

  protected

  def authenticate_admin
    redirect_to(dashboard_path, alert: 'Access denied.') unless current_user&.admin? # &. is safer way to access (?)
  end

end
