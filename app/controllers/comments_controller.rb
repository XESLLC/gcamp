class CommentsController < ApplicationController

  def create
    @task = Task.find(params[:task_id])
    @project = @task.project
    @comment = Comment.new(comment_params.merge(task_id: params[:task_id]).merge(user_id: current_user[:id]))
    if @comment.save
      redirect_to project_task_path(@project, @task)
    else
      redirect_to project_task_path(@project, @task)
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:comment, :user_id, :task_id)
  end

end
