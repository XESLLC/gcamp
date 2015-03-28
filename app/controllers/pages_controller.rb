class PagesController < ApplicationController

 before_action :check_if_current_user

 private

 def check_if_current_user
    if !current_user
      redirect_to root_path, notice: "You must sign in"
    end
  end

  def check_member_of_project
    is_project_member = true
    if params[:project_id]
      is_project_member = false
      Project.find(params[:project_id]).memberships.each do |membership|
        if membership.user.id == current_user.id
          is_project_member = true
        end
      end
    end
    if is_project_member == false
      redirect_to projects_path, notice: "You do not have access to that project"
    end
  end

  def check_member_of_project_id
    is_project_member = true
    if params[:project_id]
      is_project_member = false
      Project.find(params[:project_id]).memberships.each do |membership|
        if membership.user.id == current_user.id
          is_project_member = true
        end
      end
    end
    if is_project_member == false
      redirect_to projects_path, notice: "You do not have access to that project"
    end
  end

  def check_member_of_task
    is_task_member = true
    if params[:project_id]
      is_task_member = false
      Project.find(params[:project_id]).users.each do |user|
        if user.id == current_user.id
          is_task_member = true
        end
      end
    end
    if is_task_member == false
      redirect_to projects_path, notice: "You do not have access to that project"
    end
  end

  def check_user_role
    id = params[:id]
    if params[:project_id]
      id = params[:project_id]
    end
    if Project.find(id).memberships.find_by(user_id: current_user[:id]).role != "1"
      redirect_to project_path(id), notice: "You do not have access"
    end
  end

  def check_member_deletes_self
    id = params[:id]
    if params[:project_id]
      id = params[:project_id]
    end

    if params["action"] == "destroy" && current_user.memberships.find_by(project_id: id).role == "2"
      @project = Project.find(id)
      @membership = @project.memberships.find(params[:id])
      if @membership.destroy
        redirect_to projects_path, notice: "#{@membership.user.full_name} successfully removed."
      end
    end
  end
  
end
