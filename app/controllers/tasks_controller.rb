class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy, :reply]
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user, only: :destroy


  def index
    @tasks = Task.all
  end


  def show
  end

  def reply
    if current_user.voted_for? @task
      @task.no_reply_by current_user
    else
      @task.reply_by current_user
    end
  end

  def new
    @task = Task.new
  end

  def edit
    if @task.user_id == current_user.id
      #OK
    else
      redirect_to root_path, notice: 'Вы не автор этого задания!'
    end
  end

  def create
    @task = current_user.tasks.build(task_params)
    @task.user_id = current_user.id

    respond_to do |format|
      if @task.save
        format.html { redirect_to @task, notice: 'Задание опубликовано!' }
        format.json { render :show, status: :created, location: @task }
      else
        format.html { render :new }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    if @task.user_id == current_user.id
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to @task, notice: 'Задание обновлено!' }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
    else
      redirect_to root_path, notice: 'Вы не автор этого задания!'
    end
  end

  def destroy
    if @task.user_id == current_user.id
    @task.destroy
    respond_to do |format|
      format.html { redirect_to tasks_url, notice: 'Задание удалено!' }
      format.json { head :no_content }
    end
    else
      redirect_to root_path, notice: 'Вы не автор этого задания!'
    end
  end

  private

    def set_task
      @task = Task.find(params[:id])
    end


    def task_params
      params.require(:task).permit(:title, :content)
    end

    def correct_user
      @task = current_user.tasks.find_by(id: params[:id])
      redirect_to root_url if @task.nil?
    end
end
