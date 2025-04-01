<script setup>
import { ref, onMounted } from 'vue'
import { api } from '../api'
import { toast } from 'vue3-toastify'
import 'vue3-toastify/dist/index.css'
import './TaskList.css'

const emit = defineEmits()

const tasks = ref([])

const fetchTasks = async () => {
  try {
    const response = await api.get('/tasks')
    tasks.value = response.data
  } catch (error) {
    console.error('Erro ao buscar tarefas:', error)
  }
}

const deleteTask = async (id) => {
  try {
    await api.delete(`/tasks/${id}`)
    toast('Tarefa removida!', {
      autoClose: 2000,
      type: 'success',
    })
    fetchTasks()
  } catch (error) {
    toast('Erro ao excluir tarefa!', {
      autoClose: 2000,
      type: 'error',
    })
    console.error('Erro ao excluir tarefa:', error)
  }
}

const editTask = (task) => {
  window.scrollTo(0, 0)
  emit('editTask', task)
}

onMounted(fetchTasks)
</script>

<template>
  <div class="container">
    <h2>📋 Lista de Tarefas</h2>
    <div class="scrollable">
      <ul v-if="tasks.length > 0">
        <li v-for="task in tasks" :key="task.id">
          <div class="task-info">
            <p class="title">{{ task.title }}</p>
            <p class="description">{{ task.description }}</p>
            <span class="status">{{ task.status }}</span>
          </div>

          <button class="edit-btn" @click="editTask(task)">✏️ Editar</button>
          <button class="delete-btn" @click="deleteTask(task.id)">🗑️ Excluir</button>
        </li>
      </ul>
      <p v-else>Nenhuma tarefa encontrada.</p>
    </div>
  </div>
</template>
