require 'rails_helper'

RSpec.describe ConvitesController, type: :controller do
  let!(:administrador) { create(:administrador) }
  let!(:convite) { create(:convite, administrador: administrador) }

  describe 'GET #index' do
    xit 'exibe a lista de convites com filtros' do
      get :index, params: { email: convite.email, start_date: '2025-01-01', end_date: '2025-01-31' }
      expect(response).to be_successful
      expect(assigns(:convites)).to include(convite)
    end

    it 'exibe todos os convites quando nenhum filtro é aplicado' do
      get :index
      expect(response).to be_successful
      expect(assigns(:convites)).to include(convite)
    end
  end

  describe 'GET #new' do
    it 'exibe o formulário para criar um novo convite' do
      get :new
      expect(response).to be_successful
      expect(assigns(:convite)).to be_a_new(Convite)
      expect(assigns(:administradores)).to be_present
    end
  end

  describe 'POST #create' do
    context 'quando os parâmetros são válidos' do
      let(:valid_params) do
        {
          convite: {
            email: 'test@example.com',
            empresa_id: 1,
            status: 'pending',
            data_envio: '2025-01-01',
            administrador_id: administrador.id
          }
        }
      end

      xit 'cria o convite e redireciona para a lista de convites' do
        expect {
          post :create, params: valid_params
        }.to change(Convite, :count).by(1)
        expect(response).to redirect_to(convites_path)
        expect(flash[:notice]).to eq('Convite criado com sucesso!')
      end
    end

    context 'quando os parâmetros são inválidos' do
      let(:invalid_params) { { convite: { email: '', empresa_id: '', status: '', data_envio: '', administrador_id: '' } } }

      xit 'não cria o convite e renderiza o formulário novamente' do
        expect {
          post :create, params: invalid_params
        }.not_to change(Convite, :count)
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'GET #edit' do
    it 'exibe o formulário para editar um convite' do
      get :edit, params: { id: convite.id }
      expect(response).to be_successful
      expect(assigns(:convite)).to eq(convite)
      expect(assigns(:administradores)).to be_present
    end
  end

  describe 'PATCH #update' do
    context 'quando os parâmetros são válidos' do
      let(:valid_params) { { convite: { status: 'accepted' } } }

      xit 'atualiza o convite e redireciona para a lista de convites' do
        convite = create(:convite, status: 'pendente')
        patch :update, params: { id: convite.id, convite: { status: 'accepted' } }

        convite.reload
        expect(convite.status).to eq('accepted')
      end
    end

    context 'quando os parâmetros são inválidos' do
      let(:invalid_params) { { convite: { email: '' } } }

      it 'não atualiza o convite e renderiza o formulário de edição' do
        patch :update, params: { id: convite.id, convite: invalid_params[:convite] }
        expect(convite.reload.email).not_to eq('')
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'GET #show' do
    it 'redireciona para a lista de convites com um alerta' do
      get :show, params: { id: convite.id }
      expect(response).to redirect_to(convites_path)
      expect(flash[:alert]).to eq("Ação 'show' não disponível para Convites.")
    end
  end

  describe 'DELETE #destroy' do
    it 'deleta o convite e redireciona para a lista de convites' do
      convite_to_destroy = create(:convite)
      expect {
        delete :destroy, params: { id: convite_to_destroy.id }
      }.to change(Convite, :count).by(-1)
      expect(response).to redirect_to(convites_path)
      expect(flash[:notice]).to eq('Convite excluído com sucesso!')
    end
  end
end
