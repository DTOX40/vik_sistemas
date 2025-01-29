FactoryBot.define do
  factory :empresa do
    nome { Faker::Company.name }
    cnpj { "12345678000195" }
  end
end
