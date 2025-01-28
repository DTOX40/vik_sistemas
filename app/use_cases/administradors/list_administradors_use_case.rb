module Administradors
  class ListAdministradorsUseCase
    def execute
      Administrador.all
    end
  end
end
