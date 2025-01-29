require 'rails_helper'

RSpec.describe 'Administradors Use Cases', type: :model do
  let(:valid_params) do
    {
      nome: 'João',
      email: 'joao@example.com',
      password: 'password',
      password_confirmation: 'password'
    }
  end

  let(:invalid_params) do
    {
      nome: '',
      email: 'joao@example.com',
      password: 'password',
      password_confirmation: 'password'
    }
  end

  let(:administrador) { Administrador.create(valid_params) }
  let(:use_case) { described_class.new(valid_params) }

  context 'quando cria o administrador' do
    context 'quando os parâmetros são válidos' do
      xit 'cria o administrador e retorna sucesso' do
        use_case = Administradors::CreateAdministradorUseCase.new(valid_params)
        result = use_case.execute

        expect(result.success?).to be(true)
        expect(result.administrador).to be_persisted
        expect(result.errors).to be_empty
      end
    end

    context 'quando os parâmetros são inválidos' do
      xit 'não cria o administrador e retorna erro' do
        use_case = Administradors::CreateAdministradorUseCase.new(invalid_params)
        result = use_case.execute

        expect(result.success?).to be(false)
        expect(result.errors).to include("Nome can't be blank")
      end
    end
  end

  context 'quando destrói o administrador' do
    it 'deleta o administrador com sucesso' do
      use_case = Administradors::DestroyAdministradorUseCase.new(administrador)
      result = use_case.execute

      expect(result.success?).to be(true)
      expect(Administrador.exists?(administrador.id)).to be_falsey
    end

    it 'não deleta o administrador e retorna erro se falhar' do
      allow(administrador).to receive(:destroy).and_return(false)

      use_case = Administradors::DestroyAdministradorUseCase.new(administrador)
      result = use_case.execute

      expect(result.success?).to be(false)
      expect(result.errors).to include('Erro ao tentar excluir administrador')
    end
  end

  context 'quando lista os administradores' do
    it 'retorna todos os administradores' do
      administrador_salvo = Administrador.create(valid_params)

      use_case = Administradors::ListAdministradorsUseCase.new
      result = use_case.execute

      expect(result).to include(administrador_salvo)
    end
  end

  context 'quando atualiza o administrador' do
    let(:update_params) { { nome: 'Carlos' } }

    it 'atualiza o administrador com sucesso' do
      use_case = Administradors::UpdateAdministradorUseCase.new(administrador, update_params)
      result = use_case.execute

      expect(result[:success]).to be(true)
      expect(administrador.reload.nome).to eq('Carlos')
    end

    it 'não atualiza o administrador e retorna erro' do
      invalid_update_params = { nome: '' }
      use_case = Administradors::UpdateAdministradorUseCase.new(administrador, invalid_update_params)
      result = use_case.execute

      expect(result[:success]).to be(false)
      expect(result[:errors]).to include("Nome can't be blank")
    end
  end
end
