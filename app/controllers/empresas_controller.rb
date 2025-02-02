class EmpresasController < ApplicationController
  before_action :set_empresa, only: [:edit, :update, :destroy]

  def index
    @empresas = Empresa.all
  end

  def new
    @empresa = Empresa.new
  end

  def create
    use_case = Empresas::CreateEmpresaUseCase.new(empresa_params)
    result = use_case.call

    if result.success?
      redirect_to empresas_path, notice: "Empresa criada com sucesso!"
    else
      @empresa = Empresa.new(empresa_params)
      flash[:error] = result.errors.to_sentence
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @empresa = Empresa.find(params[:id])
  end

  def update
    result = Empresas::UpdateEmpresaUseCase.new(@empresa, empresa_params).call

    if result.success?
      redirect_to empresas_path, notice: "Empresa atualizada com sucesso!"
    else
      flash[:error] = result.errors.to_sentence
      render :edit, status: :unprocessable_entity
    end
  end

  def show
    @empresa = Empresa.find(params[:id])
  end

  def destroy
    result = Empresas::DestroyEmpresaUseCase.new(@empresa).call
    if result.success?
      redirect_to empresas_path, notice: "Empresa excluída com sucesso!"
    else
      flash[:alert] = "Erro ao excluir a empresa."
      redirect_to empresas_path
    end
  end

  private

  def empresa_params
    params.require(:empresa).permit(:nome, :email, :telefone, :cnpj, :descricao)
  end

  def set_empresa
    @empresa = Empresa.find(params[:id])
  end
end
