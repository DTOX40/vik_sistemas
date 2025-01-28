module UseCases
  module Convites
    class DestroyInviteUseCase
      def initialize(invite_id)
        @invite_id = invite_id
      end

      def execute
        invite = Convite.find(@invite_id)
        invite.destroy
      end
    end
  end
end
