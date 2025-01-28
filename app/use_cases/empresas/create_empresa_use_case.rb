module Empresas
  require 'ostruct'

  class CreateEmpresaUseCase
    def initialize(params)
      @params = params
    end

    def call
      empresa = Empresa.new(@params)
      if empresa.save
        OpenStruct.new(success?: true, empresa: empresa, errors: [])
      else
        OpenStruct.new(success?: false, errors: empresa.errors.full_messages)
      end
    end
  end
end
