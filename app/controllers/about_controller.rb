class AboutController < ApplicationController

  def about
    @projects = Project.all
    @tasks =  Task.all
    @memberships = Membership.all
    @comments = Comment.all
    @user = User.all
  end

end
