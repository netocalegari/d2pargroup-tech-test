require 'rails_helper'

RSpec.describe "Task Manager API", type: :request do
  let!(:tasks) { create_list(:task, 3) } # Cria 3 tarefas no banco antes de cada teste
  let(:task_id) { tasks.first.id }

  # Teste do endpoint GET /tasks
  describe "GET /tasks" do
    it "retorna todas as tarefas" do
      get "/tasks"

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body).size).to eq(3)
    end
  end

  # Teste do endpoint GET /tasks/:id
  describe "GET /tasks/:id" do
    context "quando a tarefa existe" do
      it "retorna a tarefa" do
        get "/tasks/#{task_id}"

        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)["id"]).to eq(task_id)
      end
    end

    context "quando a tarefa não existe" do
      it "retorna status 404" do
        get "/tasks/99999"

        expect(response).to have_http_status(:not_found)
      end
    end
  end

  # Teste do endpoint POST /tasks
  describe "POST /tasks" do
    let(:valid_params) { { title: "Nova Tarefa", description: "Descrição teste", status: "pendente" } }

    context "quando os dados são válidos" do
      it "cria uma nova tarefa" do
        post "/tasks", params: valid_params

        expect(response).to have_http_status(:created)

        created_task = JSON.parse(response.body)
        
        get "/tasks/#{created_task["id"]}"

        persisted_task = JSON.parse(response.body)
        expect(persisted_task["id"]).to eq(created_task["id"])
        expect(persisted_task["title"]).to eq("Nova Tarefa")
        expect(persisted_task["description"]).to eq("Descrição teste")
        expect(persisted_task["status"]).to eq("pendente")
      end
    end

    context "quando os dados são inválidos" do
      it "retorna erro 422" do
        post "/tasks", params: { title: "" } 

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
  
  # Teste do endpoint PUT /tasks/:id
  describe "PUT /tasks/:id" do
    let(:valid_update_params) { { title: "Tarefa atualizada", status: "concluido" } }

    context "quando a tarefa existe" do
      it "atualiza a tarefa" do
        put "/tasks/#{task_id}", params: valid_update_params

        expect(response).to have_http_status(:no_content)

        get "/tasks/#{task_id}"

        updated_task = JSON.parse(response.body)
        expect(updated_task["title"]).to eq("Tarefa atualizada")
        expect(updated_task["status"]).to eq("concluido")
      end
    end

    context "quando a tarefa não existe" do
      it "retorna status 404" do
        put "/tasks/99999", params: valid_update_params
  
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  # Teste do endpoint DELETE /tasks/:id
describe "DELETE /tasks/:id" do
  context "quando a tarefa existe" do
    it "deleta a tarefa" do
      delete "/tasks/#{task_id}"

      expect(response).to have_http_status(:no_content)
      expect(Task.exists?(task_id)).to be_falsey
    end
  end

  context "quando a tarefa não existe" do
    it "retorna status 404" do
      delete "/tasks/99999"

      expect(response).to have_http_status(:not_found)
    end
  end
end
end
