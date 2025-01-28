module UseCases
  module Convites
    class CreateInviteUseCase
      def initialize(invite_params)
        @invite_params = invite_params
      end

      def execute
        convite = Convite.create(@invite_params)

        if convite.persisted?
          Rails.logger.debug("Convite criado com sucesso!")
        else
          Rails.logger.debug("Erro ao criar convite: #{convite.errors.full_messages}")
        end

        convite
      end
    end
  end
end
