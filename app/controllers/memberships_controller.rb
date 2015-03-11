class MembershipsController < ApplicationController

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

  private

  def membership_params
    params.require(:membership).permit(:role, :user_id)
  end

end
