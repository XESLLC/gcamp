class ProjectsController < PagesController

  before_action :check_member_of_project
  before_action :check_user_role, only: [:edit, :update, :destroy]

  def index
    if current_user.admin
      @projects = Project.all
    else
      @projects = User.find(current_user.id).projects
    end
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)
    if @project.save
      Membership.create!(role: 1, project_id: @project.id, user_id: current_user.id )
      redirect_to project_tasks_path(@project[:id]), notice: "Project was successfully created."
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
    if current_user.admin
      @role = "1"
    else
      @role = @project.memberships.find_by(user_id: current_user[:id]).role
    end
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
