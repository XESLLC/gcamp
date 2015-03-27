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
    if params[:id]
      is_project_member = false
      Project.find(params[:id]).memberships.each do |membership|
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
    if Project.find(params[:id]).memberships.find_by(user_id: current_user[:id]).role != "owner"
      redirect_to projects_path, notice: "You do not have access"
    end
  end

end
