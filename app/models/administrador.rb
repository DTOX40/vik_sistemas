class Administrador < ApplicationRecord
  has_secure_password

  has_many :convites
  has_many :empresas, through: :convites

  validates :email, presence: true, uniqueness: true
  validates :nome, presence: true
  validates :password, presence: true
end
