class Convite < ApplicationRecord
  belongs_to :empresa
  belongs_to :administrador
end
