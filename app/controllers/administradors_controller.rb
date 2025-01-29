class AdministradorsController < ApplicationController
  before_action :set_administrador, only: [:show, :edit, :update, :destroy]

  def index
    @administradors = Administradors::ListAdministradorsUseCase.new.execute
  end

  def new
    @administrador = Administrador.new
  end

  def create
    administrador = Administrador.find_by(email: params[:email])
    if administrador&.authenticate(params[:password])
      session[:administrador_id] = administrador.id
      logger.debug "Administrador logado: #{administrador.email}"  # Debug
      redirect_to welcome_path
    else
      flash[:alert] = 'Credenciais inválidas'
      render :new
    end
  end

  def edit; end

  def update
    result = Administradors::UpdateAdministradorUseCase.new(@administrador, administrador_params).execute
    if result[:success]
      redirect_to administradors_path, notice: "Administrador atualizado com sucesso."
    else
      flash.now[:alert] = result[:errors].join(", ")
      render :edit
    end
  end

  def show
    @administrador = Administrador.find(params[:id])
  end

  def destroy
    use_case = Administradors::DestroyAdministradorUseCase.new(@administrador)
    result = use_case.execute

    if result.success?
      redirect_to administradors_path, notice: 'Administrador excluído com sucesso.'
    else
      redirect_to administradors_path, alert: 'Erro ao excluir administrador.'
    end
  end

  private

  def set_administrador
    @administrador = Administrador.find_by(id: params[:id])
    if @administrador.nil?
      redirect_to administradors_path, alert: "Administrador não encontrado."
    end
  end

  def administrador_params
    params.require(:administrador).permit(:nome, :email, :password, :password_confirmation)
  end
end
