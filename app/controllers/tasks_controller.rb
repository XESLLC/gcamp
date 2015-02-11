class TasksController < ApplicationController


  def index
    @tasks = Task.all
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save
    redirect_to tasks: :show, notice: 'Contact was successfully created.'
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
    redirect_to tasks: :show, notice: 'Contact was successfully updated.'
    end
  end

  def destroy
    if @task.update(task_params)
      redirect_to tasks: :show, notice: 'Contact was successfully deleted.'
    else
      render :edit
    end
  end


  private
     def task_params
       params.require(:task).permit(:description)
     end


end
