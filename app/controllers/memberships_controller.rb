class MembershipsController < PagesController
before_action :check_member_of_project_id

  def index
    @project = Project.find(params[:project_id])
    @membership = @project.memberships.new
    @memberships = @project.memberships.all
    @users = User.all
  end


  def create
    @project = Project.find(params[:project_id])
    @memberships = @project.memberships.all
    @membership = @project.memberships.new(membership_params)
    if @membership.save
      redirect_to project_memberships_path, notice: "#{@membership.user.full_name} was successfully added."
    else
      render :index
    end
  end

  def update
    @project = Project.find(params[:project_id])
    @memberships = @project.memberships.all
    @membership = @project.memberships.find(params[:id])
    if @membership.update(membership_params)
      redirect_to project_memberships_path, notice: "#{@membership.user.full_name} was successfully updated."
    else
      render :index
    end
  end

  def destroy
    @project = Project.find(params[:project_id])
    @membership = @project.memberships.find(params[:id])
    if @membership.destroy
      redirect_to project_memberships_path, notice: "#{@membership.user.full_name} was successfully destroyed."
    else
      render :index
    end
  end

  private

  def membership_params
    params.require(:membership).permit(:role, :user_id, :project_id)
  end

end
