require 'rails_helper'

RSpec.describe AdministradorsController, type: :controller do
  let!(:administrador) { create(:administrador) }
  let(:valid_attributes) { { nome: 'João', email: 'joao@example.com', password: 'password', password_confirmation: 'password' } }
  let(:invalid_attributes) { { nome: '', email: 'joao@example.com', password: 'password', password_confirmation: 'password' } }

  describe 'GET #index' do
    xit 'atribui todos os administradores como @administradores' do
      administrador = create(:administrador)
      get :index
      expect(assigns(:administradors)).to eq([administrador])
    end
  end

  describe 'GET #show' do
    it 'atribui o administrador solicitado como @administrador' do
      get :show, params: { id: administrador.id }
      expect(assigns(:administrador)).to eq(administrador)
    end

    it 'redireciona se administrador não for encontrado' do
      get :show, params: { id: 999 }
      expect(response).to redirect_to(administradors_path)
      expect(flash[:alert]).to eq('Administrador não encontrado.')
    end
  end

  describe 'GET #new' do
    it 'atribui um novo administrador como @administrador' do
      get :new
      expect(assigns(:administrador)).to be_a_new(Administrador)
    end
  end

  describe 'POST #create' do
    context 'com atributos válidos' do
      xit 'cria um novo administrador e redireciona para o índice' do
        post :create, params: { administrador: valid_attributes }
        expect(response).to redirect_to(administradors_path)
        expect(flash[:error]).to be_nil
      end
    end

  context 'com atributos inválidos' do
    xit 'não cria um novo administrador e renderiza a página de novo' do
      post :create, params: { administrador: invalid_attributes }
      expect(response).to render_template(:new)
      expect(flash[:error]).to include("Nome não pode ficar em branco")
    end
  end
end

describe 'GET #edit' do
  it 'atribui o administrador solicitado como @administrador' do
    get :edit, params: { id: administrador.id }
    expect(assigns(:administrador)).to eq(administrador)
  end
end

describe 'PATCH #update' do
  context 'com atributos válidos' do
    xit 'atualiza o administrador solicitado e redireciona para o índice' do
      patch :update, params: { id: administrador.id, administrador: { nome: 'Novo Nome' } }
      expect(response).to redirect_to(administradors_path)
      expect(flash[:notice]).to eq('Administrador atualizado com sucesso.')
    end
  end

  context 'com atributos inválidos' do
    it 'não atualiza o administrador e renderiza a página de edição' do
      patch :update, params: { id: administrador.id, administrador: { nome: '' } }
      expect(response).to render_template(:edit)
      expect(flash[:alert]).to include("Nome can't be blank")
    end
  end
end

describe 'DELETE #destroy' do
  context 'quando bem-sucedido' do
    it 'destrói o administrador solicitado e redireciona para o índice' do
      delete :destroy, params: { id: administrador.id }
      expect(response).to redirect_to(administradors_path)
      expect(flash[:notice]).to eq('Administrador excluído com sucesso.')
    end
  end

    context 'quando malsucedido' do
      it 'não destrói o administrador e redireciona para o índice' do
        allow_any_instance_of(Administrador).to receive(:destroy).and_return(false)
        delete :destroy, params: { id: administrador.id }
        expect(response).to redirect_to(administradors_path)
        expect(flash[:alert]).to eq('Erro ao excluir administrador.')
      end
    end
  end
end
