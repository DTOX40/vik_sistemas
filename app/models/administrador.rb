class Administrador < ApplicationRecord
  self.table_name = 'administradors'
  has_secure_password

  has_many :convites
  has_many :empresas, through: :convites

  validates :email, presence: true, uniqueness: true
  validates :nome, presence: true
  validates :password, presence: true
end
