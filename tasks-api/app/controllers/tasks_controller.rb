class TasksController < ApplicationController
  before_action :set_task, only: [:show, :update, :destroy]

  # GET /tasks - Lista todas as tarefas
  def index
    tasks = Task.all
    render json: tasks
  end

  # GET /tasks/:id - Busca tarefa por id
  def show 
    render json: @task
  end

  # POST /tasks - Cria uma nova tarefa
  def create
    task = Task.new(task_params)
    puts task
    if task.save
      render json: task, status: :created
    else
      render json: {errors: task.errors}, status: :unprocessable_entity
    end
  end

  # PUT /tasks/:id - Atualiza uma tarefa
  def update
    if @task.update(task_params)
      render json: @task, status: :no_content
    else
      render json: {errors: @task.errors}, status: :unprocessable_entity
    end
  end

  # DELETE /tasks/:id - Deleta uma tarefa
  def destroy
    @task.destroy
    head :no_content
  end

  private 

  def set_task
    @task = Task.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Tarefa não encontrada' }, status: :not_found
  end

  def task_params
    params.permit(:title, :description, :status)
  end
end
