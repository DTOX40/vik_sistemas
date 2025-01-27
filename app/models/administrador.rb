class Administrador < ApplicationRecord
  has_secure_password
  has_many :convites
  has_many :empresas, through: :convites
end
