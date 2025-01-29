require 'rails_helper'

RSpec.describe EmpresasController, type: :controller do
  describe 'POST #create' do
    let(:valid_attributes) { { nome: "Empresa Teste" } }
    let(:invalid_attributes) { { nome: "" } }

    context 'com atributos válidos' do
      it 'cria uma nova empresa e redireciona para a página de empresas' do
        empresa_params = { cnpj: '12345678000195', nome: 'Empresa Teste', endereco: 'Rua Teste' }

        post :create, params: { empresa: empresa_params }
        expect(response).to redirect_to(empresas_path)
        expect(Empresa.last.nome).to eq("Empresa Teste")
      end
    end

    context 'com atributos inválidos' do
      it 'não cria uma nova empresa e renderiza a página de novo' do
        post :create, params: { empresa: invalid_attributes }
        expect(response).to render_template(:new)
        expect(flash[:error]).to include("Nome can't be blank")
      end
    end
  end

  describe 'PATCH #update' do
    let!(:empresa) { create(:empresa) }
    let(:new_attributes) { { nome: "Nome Atualizado" } }

    context 'com atributos válidos' do
      it 'atualiza a empresa solicitada e redireciona para o índice' do
        patch :update, params: { id: empresa.id, empresa: new_attributes }
        empresa.reload
        expect(empresa.nome).to eq("Nome Atualizado")
        expect(response).to redirect_to(empresas_path)
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:empresa) { create(:empresa) }

    it 'destrói a empresa solicitada e redireciona para o índice' do
      delete :destroy, params: { id: empresa.id }
      expect(Empresa.exists?(empresa.id)).to be_falsey
      expect(response).to redirect_to(empresas_path)
    end
  end
end
