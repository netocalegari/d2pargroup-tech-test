<script setup>
import { ref, onMounted } from 'vue'
import { api } from '../api'
import { toast } from 'vue3-toastify'
import 'vue3-toastify/dist/index.css'

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

<style>
.container {
  max-width: 600px;
  margin: 20px auto;
  padding: 20px;
  background: #ffffff;
  border-radius: 8px;
  box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
}
.scrollable {
  max-height: 36vh;
  overflow-y: scroll;
}
h2 {
  text-align: center;
  color: #333;
}
ul {
  list-style: none;
  padding: 0;
}
li {
  display: flex;
  justify-content: space-between;
  align-items: center;
  background: #f9f9f9;
  padding: 12px;
  margin: 10px 0;
  border-radius: 6px;
}
.task-info {
  flex: 1;
}
.title {
  font-weight: bold;
  color: #222;
}
.description {
  font-size: 0.9em;
  color: #555;
}
.status {
  font-size: 0.8em;
  color: white;
  background: #007bff;
  padding: 3px 8px;
  border-radius: 4px;
}
.delete-btn {
  background: #e74c3c;
  color: white;
  border: none;
  padding: 6px 12px;
  margin-left: 5px;
  cursor: pointer;
  border-radius: 4px;
  transition: 0.3s;
}
.delete-btn:hover {
  background: #c0392b;
}
.edit-btn {
  background: #007bff;
  color: white;
  border: none;
  padding: 6px 12px;
  cursor: pointer;
  border-radius: 4px;
  transition: 0.3s;
  margin-left: 10px;
}

.edit-btn:hover {
  background: #0056b3;
}
</style>
