class TasksController < ApplicationController
  def user_logged_in
    if current_user
    else
      redirect_to signin_path, alert: "You must sign in"
    end
  end

before_action :user_logged_in


  def index
    @tasks = Task.all
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to task_path(@task[:id]), notice: 'Task was successfully created.'
    else
      render :new
    end
  end

  def show
    @task = Task.find(params[:id])
  end

  def edit
     @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])
    if @task.update(task_params)
    redirect_to task_path, notice: 'Task was successfully updated.'
    else
     render :edit
    end
  end

  def destroy
    task = Task.find(params[:id])
    if task.destroy
      redirect_to tasks_path, notice: 'Task was successfully deleted.'
    else
      render :edit
    end

  end

  private
     def task_params
       params.require(:task).permit(:description, :checkbox, :due_date)
     end


end
