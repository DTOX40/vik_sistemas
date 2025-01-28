module UseCases
  module Convites
    class ListInviteUseCase
      def initialize(filters = {})
        @filters = filters
      end

      def execute
        convites = Convite.all

        convites = convites.where('email LIKE ?', "%#{@filters[:email]}%") if @filters[:email].present?
        convites = convites.where(empresa_id: @filters[:empresa_id]) if @filters[:empresa_id].present?
        convites = convites.where(status: @filters[:status]) if @filters[:status].present?
        convites = convites.where(data_envio: @filters[:data_envio]) if @filters[:data_envio].present?

        convites
      end
    end
  end
end
