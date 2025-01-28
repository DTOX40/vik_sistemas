module UseCases
  module Convites
    class UpdateInviteUseCase
      def initialize(invite_id, invite_params)
        @invite_id = invite_id
        @invite_params = invite_params
      end

      def execute
        invite = Invite.find(@invite_id)
        invite.update(@invite_params)
      end
    end
  end
end
