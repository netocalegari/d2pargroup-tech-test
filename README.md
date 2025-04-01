# README - Tech Challenge - Gerenciamento de Tarefas

## 🚀 Visão Geral

Este projeto consiste em uma aplicação de gerenciamento de tarefas com:

- **Backend**: API Ruby on Rails
- **Frontend**: Aplicação Vue.js
- **Infraestrutura**: Docker para conteinerização
- **Testes**: Testes unitários com Rspec

## 📋 Pré-requisitos

### Para uso com Docker:

- [Docker](https://docs.docker.com/get-docker/)
- Docker Compose (vem incluído com o Docker Desktop)

### Para uso sem Docker:

- Ruby
- Rails
- Node.js

## 🐳 Execução com Docker (Recomendado)

1. Clone o repositório:

   ```bash
   git clone https://github.com/netocalegari/quindtech-tech-test.git
   cd quindtech-tech-test
   ```

2. Iniciar container:

   ```bash
   docker-compose up -d

   ```

3. Acessar aplicação:

   ```bash
   Frontend -> http://localhost:5173
   Backend -> http://localhost:3000

   ```

   ### Atenção: pode levar alguns minutos para o container carregar complemente e disponibilizar todos os recursos

4. Executando testes:
   - Com o container rodando, execute o seguinte:
     ```bash
     docker-compose exec api sh
     bundle exec rspec
     ```

## Execução sem Docker

1. Clone o repositório:

   ```bash
   git clone https://github.com/netocalegari/quindtech-tech-test.git
   cd quindtech-tech-test

   ```

2. Acesse o diretório da API e e inicie o servidor:

   ```bash
   cd tasks-api
   bundle install
   rails db:migrate
   rails server

   URL disponível -> http://localhost:3000

   ```

3. Acesse o diretório do frontend e inicie o servidor:

   ```bash
   cd task-manager-ui
   npm install
   npm run dev

   URL disponível -> http://localhost:5173

   ```

4. Executando testes:

   - Dentro do diretório da API, rodar o comando

     ```bash
     rspec

     ```

## Endpoints da api

- A API possui os seguintes endpoints:
  **URL base**: http://localhost:3000
  - **🔍 Listar todas as tarefas**
    GET /tasks
  - 🔎 Obter uma tarefa por ID
    GET /tasks/:id
  - ➕ Criar uma nova tarefa
    POST /tasks
  - ✏️ Atualizar uma tarefa existente
    PUT /tasks/:id
  - 🗑️ Excluir uma tarefa
    DELETE /tasks/:id
