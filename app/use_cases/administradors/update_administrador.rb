module Administradors
  class UpdateAdministrador
    def self.call(administrador, params)
      if administrador.update(params)
        { success: true, administrador: administrador }
      else
        { success: false, errors: administrador.errors.full_messages }
      end
    end
  end
end
