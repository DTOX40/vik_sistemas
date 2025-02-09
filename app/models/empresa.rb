class Empresa < ApplicationRecord
  has_many :convites
  has_many :administradores, through: :convites

  validates :cnpj, presence: true
  validates :nome, presence: true, uniqueness: true
end