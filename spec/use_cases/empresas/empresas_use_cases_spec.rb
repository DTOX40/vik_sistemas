require 'rails_helper'

RSpec.describe 'Empresas Use Cases' do
  let(:valid_params) { { nome: 'Empresa Teste', cnpj: '12345678000199' } }
  let(:invalid_params) { { nome: '', cnpj: '12345678' } }
  let(:empresa) { create(:empresa) }

  describe 'CreateEmpresaUseCase' do
    context 'com atributos válidos' do
      it 'cria uma nova empresa com sucesso' do
        use_case = Empresas::CreateEmpresaUseCase.new(valid_params)
        result = use_case.call

        expect(result.success?).to be true
        expect(result.empresa).to be_persisted
      end
    end

    context 'com atributos inválidos' do
      it 'não cria a empresa e retorna erros' do
        use_case = Empresas::CreateEmpresaUseCase.new(invalid_params)
        result = use_case.call

        expect(result.success?).to be false
        expect(result.errors).to include("Nome can't be blank")
      end
    end
  end

  describe 'DestroyEmpresaUseCase' do
    context "quando a empresa pode ser deletada" do
      it "deleta a empresa com sucesso" do
        use_case = Empresas::DestroyEmpresaUseCase.new(empresa)
        result = use_case.call

        expect(result.success?).to eq(true)
        expect(result.errors).to be_empty
      end
    end

    context 'quando a empresa não pode ser deletada' do
      it "retorna erro" do
        allow(empresa).to receive(:destroy).and_return(false)
        empresa.errors.add(:base, 'Erro ao deletar a empresa')

        use_case = Empresas::DestroyEmpresaUseCase.new(empresa)
        result = use_case.call

        expect(result.success?).to eq(false)
        expect(result.errors).to include('Erro ao deletar a empresa')
      end
    end
  end

  describe 'UpdateEmpresaUseCase' do
    context 'com atributos válidos' do
      it 'atualiza a empresa com sucesso' do
        updated_params = { nome: 'Empresa Atualizada' }
        use_case = Empresas::UpdateEmpresaUseCase.new(empresa, updated_params)
        result = use_case.call

        expect(result.success?).to be true
        expect(result.empresa.nome).to eq('Empresa Atualizada')
      end
    end

    context 'com atributos inválidos' do
      it 'não atualiza a empresa e retorna erros' do
        invalid_params = { nome: '' }
        use_case = Empresas::UpdateEmpresaUseCase.new(empresa, invalid_params)
        result = use_case.call

        expect(result.success?).to be false
        expect(result.errors).to include("Nome can't be blank")
      end
    end
  end
end
