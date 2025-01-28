require 'ostruct'

module Administradors
  class DestroyAdministradorUseCase
    def initialize(administrador)
      @administrador = administrador
    end

    def execute
      if @administrador.destroy
        OpenStruct.new(success?: true, errors: [])
      else
        OpenStruct.new(success?: false, errors: @administrador.errors.full_messages)
      end
    end
  end
end
