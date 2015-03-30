class PagesController < ApplicationController

 before_action :user_logged_in
 before_action :pages

 private

 def user_logged_in
   if !current_user
     redirect_to signin_path, alert: "You must sign in"
   end
 end

 def pages
   if current_user.admin
     @user_projects = Project.all
   else
     @user_projects = current_user.projects
   end
 end

  def check_if_proper_user
    if !current_user.admin
      if params[:id] != current_user.id.to_s
      render file: 'public/404.html', alert: :not_found, layout: false
      end
    end
  end

  def check_member_of_project
    is_project_member = true
    if params[:project_id]
      is_project_member = false
      Project.find(params[:project_id]).memberships.each do |membership|
        if membership.user.id == current_user.id || current_user.admin
          is_project_member = true
        end
      end
    end
    if is_project_member == false
      redirect_to projects_path, alert: "You do not have access to that project"
    end
  end

  def check_member_of_task
    is_task_member = true
    if params[:project_id]
      is_task_member = false
      Project.find(params[:project_id]).users.each do |user|
        if user.id == current_user.id || current_user.admin
          is_task_member = true
        end
      end
    end
    if is_task_member == false
      redirect_to projects_path, alert: "You do not have access to that project"
    end
  end

  def check_user_role
    id = params[:id]
    if params[:project_id]
      id = params[:project_id]
    end
    if current_user.admin
      role = "1"
    else
      role = Project.find(id).memberships.find_by(user_id: current_user[:id]).role
    end
    if role != "1"
      redirect_to project_path(id), alert: "You do not have access"
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

  def ensure_admin_to_make_admin
    if params[:user].methods.include?(:admin)
      if params[:user].admin == true
      admin = User.find(current_user[:id]).admin
      params.merge(admin: admin)
      end
    end
  end

end
