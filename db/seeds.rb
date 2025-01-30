# db/seeds.rb

puts "Limpando o banco de dados..."
Convite.destroy_all
Empresa.destroy_all
Administrador.destroy_all

puts "Criando administradores..."
admin1 = Administrador.create!(
  email: "admin@teste.com",
  nome: "João Silva",
  password: "senha123",
  password_confirmation: "senha123"
)

admin2 = Administrador.create!(
  email: "maria.souza@teste.com",
  nome: "Maria Souza",
  password: "senha123",
  password_confirmation: "senha123"
)

puts "Criando empresas..."
empresa_a = Empresa.create!(
  nome: "Empresa A",
  cnpj: "12.345.678/0001-90",
  descricao: "Empresa focada em tecnologia.",
  email: "contato@empresa-a.com",
  telefone: "(11) 99999-9999"
)

empresa_b = Empresa.create!(
  nome: "Empresa B",
  cnpj: "98.765.432/0001-10",
  descricao: "Consultoria empresarial.",
  email: "contato@empresa-b.com",
  telefone: "(21) 98888-8888"
)

puts "Criando convites..."
# Dezembro de 2024 - Empresa A tem 10 convites ativos
10.times do |i|
  Convite.create!(
    email: "usuario#{i}@empresa-a.com",
    empresa: empresa_a,
    administrador: admin1,
    status: "ativo",
    created_at: DateTime.new(2024, 12, 15)
  )
end

# Janeiro de 2025 - 2 convites desativados
2.times do |i|
  Convite.create!(
    email: "desativado#{i}@empresa-a.com",
    empresa: empresa_a,
    administrador: admin1,
    status: "desativado",
    created_at: DateTime.new(2025, 1, 10)
  )
end

8.times do |i|
  Convite.create!(
    email: "usuario#{i+10}@empresa-a.com",
    empresa: empresa_a,
    administrador: admin1,
    status: "ativo",
    created_at: DateTime.new(2025, 2, 5),
    data_envio: DateTime.new(2025, 2, 5)
  )
end

puts "Seed concluído com sucesso!"
