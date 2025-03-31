FactoryBot.define do
  factory :task do
    title { "Tarefa de Teste" }
    description { "Descrição de teste" }
    status { "pendente" }
  end
end
