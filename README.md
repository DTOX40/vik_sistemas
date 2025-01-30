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


git clone git@github.com:DTOX40/vik_sistemas.git

- cd <vik_sistemas>
- docker-compose build

#
Após o build, crie o banco de dados, abra outro terminal rode as migrations e seeds:

* docker-compose run web rake db:create
* docker-compose run web rake db:migrate
* docker-compose run web rake db:seed
* docker-compose up

  
O sistema estará disponível em: http://0.0.0.0:3000
- email: admin@teste.com
- password: senha123

#

## Rodar o sistema sem docker
intalar  Ruby 3.3.5 e Rails 7.2.2.1


git clone <git@github.com:DTOX40/vik_sistemas.git>


cd <vik_sistemas>

bundle instal

rake db:create

rake db:migrate

rake db:seed

rails s

O sistema estará disponível em: http://0.0.0.0:3000
- email: admin@teste.com
- password: senha123
#
```bash
