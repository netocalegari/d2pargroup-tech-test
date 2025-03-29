<script setup>
import TaskList from './components/TaskList.vue'
import TaskForm from './components/TaskForm.vue'
import { ref } from 'vue'

const taskToEdit = ref(null)
const refreshTasks = ref(0)
</script>

<template>
  <div class="app-container">
    <div class="content">
      <h1>✅ Gerenciador de Tarefas</h1>

      <TaskForm :task="taskToEdit" @taskAdded="refreshTasks++" @taskUpdated="refreshTasks++" />

      <TaskList :key="refreshTasks" @editTask="taskToEdit = $event" />
    </div>
  </div>
</template>
