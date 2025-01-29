FactoryBot.define do
  factory :convite do
    administrador { create(:administrador) }
    email { "exemplo@dominio.com" }
    status { "pendente" }
    empresa { create(:empresa) }
  end
end