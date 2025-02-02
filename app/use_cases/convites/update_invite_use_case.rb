module UseCases
  module Convites
    class UpdateInviteUseCase
      def initialize(invite_id, invite_params)
        @invite_id = invite_id
        @invite_params = invite_params
      end

      def execute
        convite = Convite.find(@invite_id)
        convite.update(@invite_params)
      end
    end
  end
end
