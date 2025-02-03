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

        if @filters[:start_date].present? && @filters[:end_date].present?
          convites = convites.where(
            '(data_envio BETWEEN ? AND ?) OR (status = ? AND updated_at BETWEEN ? AND ?)',
            @filters[:start_date], @filters[:end_date],
            'Ativo', @filters[:start_date], @filters[:end_date]
          )
        elsif @filters[:start_date].present?
          convites = convites.where(
            'data_envio >= ? OR (status = ? AND updated_at >= ?)',
            @filters[:start_date], 'Ativo', @filters[:start_date]
          )
        elsif @filters[:end_date].present?
          convites = convites.where(
            'data_envio <= ? OR (status = ? AND updated_at <= ?)',
            @filters[:end_date], 'Ativo', @filters[:end_date]
          )
        end

        convites
      end
    end
  end
end
