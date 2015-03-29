class MembershipsController < PagesController

  before_action :check_member_of_project
  before_action :check_member_deletes_self, only: :destroy
  before_action :check_user_role, only: [:edit, :update, :destroy]

  def index
    @project = Project.find(params[:project_id])
    @membership = @project.memberships.new
    @memberships = @project.memberships.all
    @users = User.all
    if current_user.admin
      @role = "1"
      @owner_count = 10
    else
      @owner_count = @memberships.count {|member| member.role == 1}
      @role = @project.memberships.find_by(user_id: current_user[:id]).role
    end
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
    @owner_count = @memberships.count {|member| member.role == 1}
    if @owner_count < 2 && @membership.role == "1"
      redirect_to project_memberships_path, alert: "Projects must have at lease one owner"
    else
      if @membership.update(membership_params)
        redirect_to project_memberships_path, notice: "#{@membership.user.full_name} was successfully updated."
      else
        render :index
      end
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
