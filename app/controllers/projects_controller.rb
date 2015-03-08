class ProjectsController < ApplicationController

  def user_logged_in
    if current_user
    else
      redirect_to signin_path, alert: "You must sign in"
    end
  end
before_action :user_logged_in

  def index

    @projects = Project.all


  end

  def new

    @project = Project.new

  end

  def create

    @project = Project.new(project_params)
    if @project.save
      redirect_to project_path(@project[:id]), notice: "Project was successfully created."
    else
      render :new
    end

  end

  def edit

    @project = Project.find(params[:id])

  end

  def update

    @project = Project.find(params[:id])
    if @project.update(project_params)
      redirect_to project_path(@project[:id]), notice: "Project was successfully updated."
    else
      render :edit
    end

  end

  def show

    @project = Project.find(params[:id])
    @task_count = @project.tasks.all.count

  end

  def destroy

    @project = Project.find(params[:id])
    if @project.destroy
      redirect_to projects_path, notice: "Project was successfully deleted."
    else
      render :show
    end

  end


  private

  def project_params

    params.require(:project).permit(:name)

  end

end
