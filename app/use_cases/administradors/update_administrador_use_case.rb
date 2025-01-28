module Administradors
  class UpdateAdministradorUseCase
    def initialize(administrador, params)
      @administrador = administrador
      @params = params
    end

    def execute
      if @administrador.update(@params)
        { success: true, administrador: @administrador }
      else
        { success: false, errors: @administrador.errors.full_messages }
      end
    end
  end
end
