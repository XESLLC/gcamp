class MembershipsController < ApplicationController

  def index
    @project = Project.find(params[:project_id])
    @memberships = @project.memberships
    @membership = Membership.new
    @users = User.all
  end

  def new

    @project = Project.find(params[:project_id])
    @membership = Membership.new

  end

  def create
    @membership = Membership.new(membership_params.merge(:project_id=> params[:project_id]))
    if @membership.save
      redirect_to project_task_path(params[:project_id], @membership[:id]), notice: 'Membership was successfully created.'
    else
      @project = Project.find(params[:project_id])
      render :new
    end

  end

  private

  def membership_params
    params.require(:membership).permit(:role)
  end

end
