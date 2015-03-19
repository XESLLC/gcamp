class TasksController < PagesController
  def user_logged_in
    if current_user
    else
      redirect_to signin_path, alert: "You must sign in"
    end
  end

before_action :user_logged_in


  def index
    @project = Project.find(params[:project_id])
    @tasks = @project.tasks
  end

  def new
    @task = Task.new
    @project = Project.find(params[:project_id])
  end

  def create
    @project = Project.find(params[:project_id])
    @task = @project.tasks.new(task_params)
    if @task.save
      redirect_to project_task_path(params[:project_id], @task[:id]), notice: 'Task was successfully created.'
    else
      render :new
    end
  end

  def show
    @project = Project.find(params[:project_id])
    @task = @project.tasks.find(params[:id])
    @comments = @task.comments.all
    @comment = @task.comments.new
  end

  def edit
    @project = Project.find(params[:project_id])
    @task = @project.tasks.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])
    if @task.update(task_params)
    redirect_to project_task_path(params[:project_id], @task[:id]), notice: 'Task was successfully updated.'
    else
      @project = Project.find(params[:project_id])
     render :edit
    end
  end

  def destroy
    @project = Project.find(params[:project_id])
    @task = @project.tasks.find(params[:id])
    if @task.destroy
      redirect_to project_tasks_path(@project), notice: 'Task was successfully deleted.'
    else
      render :edit
    end

  end

  private
     def task_params
       params.require(:task).permit(:description, :checkbox, :due_date, :project_id)
     end


end
