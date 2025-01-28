class ConvitesController < ApplicationController
  require_dependency Rails.root.join('app', 'use_cases', 'convites', 'create_invite_use_case').to_s
  require_dependency Rails.root.join('app', 'use_cases', 'convites', 'destroy_invite_use_case').to_s
  require_dependency Rails.root.join('app', 'use_cases', 'convites', 'list_invite_use_case').to_s
  require_dependency Rails.root.join('app', 'use_cases', 'convites', 'update_invite_use_case').to_s

  def index
    start_date = params[:start_date].present? ? Date.parse(params[:start_date]) : nil
    end_date = params[:end_date].present? ? Date.parse(params[:end_date]) : nil

    @convites = UseCases::Convites::ListInviteUseCase.new(
      params.slice(:email, :empresa_id, :status, :start_date, :end_date)
             .merge({ start_date: start_date, end_date: end_date })
    ).execute
  end

  def new
    @convite = Convite.new
    @administradores = Administrador.all
  end

  def create
    UseCases::Convites::CreateInviteUseCase.new(convite_params).execute
    redirect_to convites_path, notice: 'Convite criado com sucesso!'
  end

  def edit
    @convite = Convite.find(params[:id])
    @administradores = Administrador.all
  end

  def update
    @convite = Convite.find(params[:id])
    if @convite.update(convite_params)
      redirect_to convites_path, notice: 'Convite atualizado com sucesso!'
    else
      @administradores = Administrador.all
      render :edit
    end
  end

  def show
    redirect_to convites_path, alert: "Ação 'show' não disponível para Convites."
  end

  def destroy
    UseCases::Convites::DestroyInviteUseCase.new(params[:id]).execute
    redirect_to convites_path, notice: 'Convite excluído com sucesso!'
  end

  private

  def convite_params
    params.require(:convite).permit(:email, :empresa_id, :status, :data_envio, :administrador_id)
  end
end
