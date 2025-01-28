class Empresa < ApplicationRecord
  has_many :convites
  has_many :administradores, through: :convites

  validates :nome, presence: true, uniqueness: true
end
