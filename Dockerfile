# syntax=docker/dockerfile:1

# Defina a versão do Ruby
ARG RUBY_VERSION=3.3.5
FROM ruby:$RUBY_VERSION-slim AS base

# Defina o diretório de trabalho
WORKDIR /vik_sistemas

# Instalar pacotes básicos, incluindo Node.js, npm, PostgreSQL client e dependências do Rails
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y \
    curl libpq-dev nodejs npm postgresql-client build-essential git && \
    rm -rf /var/lib/apt/lists/* /var/cache/apt/archives/*

# Defina variáveis de ambiente para a produção
ENV RAILS_ENV="development" \
    BUNDLE_PATH="/usr/local/bundle" \
    BUNDLE_WITHOUT="test"

# Fase de construção - Instalar as gems e dependências JavaScript
FROM base AS build

# Instalar pacotes necessários para compilar gems
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y \
    libpq-dev pkg-config && \
    rm -rf /var/lib/apt/lists/* /var/cache/apt/archives/*

# Copiar o Gemfile e o Gemfile.lock
COPY Gemfile Gemfile.lock ./

# Instalar as gems da aplicação
RUN bundle install && \
    rm -rf ~/.bundle/ "${BUNDLE_PATH}"/ruby/*/cache "${BUNDLE_PATH}"/ruby/*/bundler/gems/*/.git

# Instalar o Yarn via npm
RUN npm install -g yarn

# Rodar o comando para gerar os binários, incluindo o bin/rails
RUN bundle exec rails app:update:bin

# Pré-compilar o código de assets (no modo development, sem precisar da chave secreta)
RUN SECRET_KEY_BASE_DUMMY=1 bundle exec rails assets:precompile

# Fase final - Configuração do ambiente de produção
FROM base

# Copiar as gems e código da fase de construção
COPY --from=build "${BUNDLE_PATH}" "${BUNDLE_PATH}"
COPY --from=build /vik_sistemas /vik_sistemas

# Criar um usuário não root para segurança
RUN groupadd --system --gid 1000 rails && \
    useradd rails --uid 1000 --gid 1000 --create-home --shell /bin/bash && \
    chown -R rails:rails /vik_sistemas

USER rails

# Configurar o entrypoint
ENTRYPOINT ["/vik_sistemas/bin/docker-entrypoint"]

# Expor a porta do servidor Rails
EXPOSE 3000

# Iniciar o servidor Rails por padrão
CMD ["./bin/rails", "server", "-b", "0.0.0.0"]
