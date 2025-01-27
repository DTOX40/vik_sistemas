module Administradors
  class CreateAdministrador
    def self.call(params)
      administrador = Administrador.new(params)
      if administrador.save
        { success: true, administrador: administrador }
      else
        { success: false, errors: administrador.errors.full_messages }
      end
    end
  end
end
