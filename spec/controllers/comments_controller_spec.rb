describe CommentsController do
  before do
    seed_test_with_user_project_membership
    @user_admin = create_admin
    session[:user_id] = @user1.id
    @task = create_task
  end

  describe "create" do
    it "saves new task" do
      post :create, {"comment"=>{user_id: User.last, task_id: @task.id, comment: "Test Comment Updated"},"task_id"=> "#{@task.id}", "project_id"=> "#{@project.id}"}
      expect(assigns(:project)).to eq(@task.project)
      expect(assigns(:task)).to eq(Task.last)
      expect(assigns(:comment)).to eq(Comment.last)
      expect(response.status).to eq(302)
    end
  end

end
