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

        if @filters[:status].present?
          convites = convites.where(status: @filters[:status])
        end

        if @filters[:start_date].present? && @filters[:end_date].present?
          convites = convites.where(data_envio: @filters[:start_date]..@filters[:end_date])
        elsif @filters[:start_date].present?
          convites = convites.where('data_envio >= ?', @filters[:start_date])
        elsif @filters[:end_date].present?
          convites = convites.where('data_envio <= ?', @filters[:end_date])
        end

        convites
      end
    end
  end
end
