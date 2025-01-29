FactoryBot.define do
  factory :administrador do
    nome { "Administrador Teste" }
    email { Faker::Internet.unique.email }
    password { "senha123" }
    password_confirmation { "senha123" }
  end
end
