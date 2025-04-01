<script setup>
import { ref, watch } from 'vue'
import { api } from '../api'
import { toast } from 'vue3-toastify'
import 'vue3-toastify/dist/index.css'
import './TaskForm.css'

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

      props.task = null
      emit('taskUpdated')
      emit('clearTask')
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
