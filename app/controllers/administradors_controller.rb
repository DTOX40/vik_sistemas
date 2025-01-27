class AdministradorsController < ApplicationController
  before_action :set_administrador, only: %i[edit update destroy]

  def index
    @administradors = Administrador.all
  end

  def new
    @administrador = Administrador.new
  end

  def create
    result = Administradors::CreateAdministrador.call(administrador_params)
    if result[:success]
      redirect_to administradors_path, notice: "Administrador criado com sucesso."
    else
      @administrador = Administrador.new(administrador_params)
      flash.now[:alert] = result[:errors].join(", ")
      render :new
    end
  end

  def edit; end

  def update
    result = Administradors::UpdateAdministrador.call(@administrador, administrador_params)
    if result[:success]
      redirect_to administradors_path, notice: "Administrador atualizado com sucesso."
    else
      flash.now[:alert] = result[:errors].join(", ")
      render :edit
    end
  end

  def destroy
    Administradors::DestroyAdministrador.call(@administrador)
    redirect_to administradors_path, notice: "Administrador excluído com sucesso."
  end

  private

  def set_administrador
    @administrador = Administrador.find(params[:id])
  end

  def administrador_params
    params.require(:administrador).permit(:nome, :email, :password, :password_confirmation)
  end
end
