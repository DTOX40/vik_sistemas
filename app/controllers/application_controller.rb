class ApplicationController < ActionController::Base
  helper_method :current_administrador

  def current_administrador
    @current_administrador ||= Administrador.find(session[:administrador_id]) if session[:administrador_id]
  end

  def require_login
    redirect_to login_path unless current_administrador
  end
end
