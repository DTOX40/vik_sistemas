class SessionsController < ApplicationController
  def new
    if session[:administrador_id]
      redirect_to welcome_path
    end
  end

  def create
    administrador = Administrador.find_by(email: params[:email])
    if administrador && administrador.authenticate(params[:password])
      session[:administrador_id] = administrador.id
      redirect_to welcome_path
    else
      flash.now[:alert] = "Email ou senha inválidos"
      render :new
    end
  end

  def destroy
    session[:administrador_id] = nil
    redirect_to login_path
  end

end
