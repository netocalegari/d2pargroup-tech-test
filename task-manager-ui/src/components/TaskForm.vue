<script setup>
import { ref, watch } from 'vue'
import { api } from '../api'
import { toast } from 'vue3-toastify'
import 'vue3-toastify/dist/index.css'

const props = defineProps({
  task: Object,
})

const emit = defineEmits()

const formData = ref({
  title: '',
  description: '',
  status: 'pendente',
})

watch(
  () => props.task,
  (newTask) => {
    if (newTask) {
      formData.value = { ...newTask }
    }
  },
  { immediate: true },
)

const submitForm = async () => {
  try {
    if (props.task) {
      await api.put(`/tasks/${props.task.id}`, formData.value)

      toast('Informações atualizadas!', {
        autoClose: 2000,
        type: 'success',
      })

      emit('taskUpdated')
    } else {
      await api.post('/tasks', formData.value)

      toast('Tarefa adicionada!', {
        autoClose: 2000,
        type: 'success',
      })

      emit('taskAdded')
    }
    formData.value = { title: '', description: '', status: 'pendente' }
  } catch (error) {
    toast('Erro ao salvar tarefa!', {
      autoClose: 2000,
      type: 'error',
    })

    console.error('Erro ao salvar a tarefa', error)
  }
}
</script>

<template>
  <div class="task-form">
    <h2>{{ task ? 'Editar Tarefa' : 'Nova Tarefa' }}</h2>
    <form @submit.prevent="submitForm">
      <div class="form-group">
        <label for="title">Título:</label>
        <input
          type="text"
          id="title"
          v-model="formData.title"
          placeholder="Título da tarefa"
          required
        />
      </div>

      <div class="form-group">
        <label for="description">Descrição:</label>
        <textarea
          id="description"
          v-model="formData.description"
          placeholder="Descrição da tarefa"
        ></textarea>
      </div>

      <div class="form-group">
        <label for="status">Status:</label>
        <select v-model="formData.status" required>
          <option value="pendente">Pendente</option>
          <option value="em andamento">Em andamento</option>
          <option value="concluido">Concluído</option>
        </select>
      </div>

      <button type="submit">{{ task ? 'Atualizar' : 'Adicionar' }} Tarefa</button>
    </form>
  </div>
</template>

<style>
.task-form {
  max-width: 600px;
  margin: 20px auto;
  padding: 20px;
  background: #ffffff;
  border-radius: 8px;
  box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
}
form {
  display: flex;
  flex-direction: column;
  gap: 10px;
}
input,
textarea,
select {
  width: 100%;
  padding: 8px;
  border: 1px solid #ccc;
  border-radius: 6px;
}
button {
  background: #28a745;
  color: white;
  border: none;
  padding: 10px;
  cursor: pointer;
  border-radius: 6px;
  transition: 0.3s;
}
button:hover {
  background: #218838;
}
</style>
