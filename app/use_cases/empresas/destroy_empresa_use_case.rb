module Empresas
  require 'ostruct'
  class DestroyEmpresaUseCase
    def initialize(empresa)
      @empresa = empresa
    end

    def call
      if @empresa.destroy
        OpenStruct.new(success?: true, errors: [])
      else
        OpenStruct.new(success?: false, errors: @empresa.errors.full_messages)
      end
    end
  end
end
