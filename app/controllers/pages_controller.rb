class PagesController < ApplicationController

 before_action :check_if_current_user

 private

 def check_if_current_user
    if !current_user
      redirect_to projects_path, notice: "You do not have access to that project"
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

end
