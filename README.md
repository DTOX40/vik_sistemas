# Sistema de Convites

Este é um sistema desenvolvido em Ruby on Rails para gerenciar convites. Siga as instruções abaixo para rodar o projeto localmente.

## Requisitos

- Ruby 3.3.5
- Rails 7.2.2.1
- Docker
- Docker Compose

## Como rodar o projeto

### 1. Clonar o repositório

Clone o repositório para sua máquina:


git clone <URL_DO_REPOSITORIO>
cd <DIRETORIO_DO_PROJETO>

docker-compose build

#
Após o build, crie o banco de dados, rode as migrations e seeds:
#

docker-compose run web rake db:create
docker-compose run web rake db:migrate
docker-compose run web rake db:seed

#
O sistema estará disponível em: http://0.0.0.0:3000/login
  email: admin@teste.com
  password: senha123

#
```bash