module Administradors
  require 'ostruct'

  class CreateAdministradorUseCase
    def initialize(params)
      @params = params
    end

    def execute
      administrador = Administrador.new(@params)
      if administrador.valid? && administrador.save
        OpenStruct.new(success?: true, administrador: administrador, errors: [])
      else
        OpenStruct.new(success?: false, errors: administrador.errors.full_messages)
      end
    end
  end
end
