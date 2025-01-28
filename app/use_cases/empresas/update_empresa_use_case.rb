module Empresas
  require 'ostruct'

  class UpdateEmpresaUseCase
    def initialize(empresa, params)
      @empresa = empresa
      @params = params
    end

    def call
      if @empresa.update(@params)
        OpenStruct.new(success?: true, empresa: @empresa, errors: [])
      else
        OpenStruct.new(success?: false, errors: @empresa.errors.full_messages)
      end
    end
  end
end
