class Task < ApplicationRecord
  validates :status, inclusion: {
    in: ["pendente", "em andamento", "concluido"],
      message: "Status inválido: %{value}. Valores permitidos são 'pendente', 'em andamento' ou 'concluido'"
  }
  validates :title, presence: {message: "Title não pode ser nulo"}
end
