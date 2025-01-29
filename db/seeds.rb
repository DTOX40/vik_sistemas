Administrador.create!(
  email: 'admin@teste.com',
  password: 'senha123',
  password_confirmation: 'senha123',
  role: 'admin'
)

puts "Administrador criado com sucesso!"
