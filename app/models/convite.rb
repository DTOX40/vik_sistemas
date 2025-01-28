class Convite < ApplicationRecord
  belongs_to :empresa
  belongs_to :administrador

  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :empresa_id, presence: true
  validates :administrador_id, presence: true
  validates :status, inclusion: { in: %w(ativo inativo pendente) }

  validates :data_envio, presence: true, if: -> { status == 'ativo' }

  validates :email, uniqueness: { scope: :empresa_id, message: "já foi convidado para essa empresa." }
end