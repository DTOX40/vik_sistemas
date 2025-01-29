require 'ostruct'

module Administradors
  class DestroyAdministradorUseCase
    def initialize(administrador)
      @administrador = administrador
    end

    def execute
      if @administrador.destroy
        OpenStruct.new(success?: true)
      else
        OpenStruct.new(success?: false, errors: ['Erro ao tentar excluir administrador'])
      end
    end
  end
end
