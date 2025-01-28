
User.create!(
  email: 'admin@teste.com',
  password: 'senhaSegura123',
  password_confirmation: 'senha123',
  role: 'admin'
)

puts "Usuário admin criado com sucesso!"
