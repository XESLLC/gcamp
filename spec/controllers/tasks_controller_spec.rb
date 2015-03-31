describe TasksController do
  before do
    seed_test_with_user_project_membership
    @user_admin = create_admin
    session[:user_id] = @user1.id
    @task = create_task
  end

  describe "index" do
    it "shows all tasks for current project only" do
      get :index, {"project_id"=> "#{@project.id}", "task"=> "@task.id"}
      expect([assigns(:project)]).to eq(@user1.projects)
      expect(assigns(:tasks)).to eq(@project.tasks)
      expect(response).to render_template("index")
    end
  end

  describe "index" do
    it "shows all tasks for admin" do
      current_user = @user_admin
      get :index, {"project_id"=> "#{@project.id}"}
      expect(assigns(:project)).to eq(@project)
      expect(response).to render_template("index")
    end
  end

  describe "new" do
    it "shows a new task page" do
      get :new, {"project_id"=> "#{@project.id}"}
      expect(assigns(:task)).to be_a_new(Task)
      expect(assigns(:project).id).to eq(@project.id)
    end
  end

  describe "create" do
    it "saves new task" do
      post :create, {"task"=>{description: "Test Description", checkbox: false, due_date: Time.now.utc + 3600, project_id: "#{@project.id}"}, "project_id"=> "#{@project.id}"}
      expect(assigns(:project)).to eq(@task.project)
      expect(assigns(:task)).to eq(Task.last)
      expect(response.status).to eq(302)
    end
  end

  describe "create" do
    it "does not save new task and renders new" do
      get :create, {"task"=>{description: nil, checkbox: false, due_date: Time.now.utc + 3600, project_id: "#{@project.id}"}, "project_id"=> "#{@project.id}"}
      expect(response.status).to eq(200)
    end
  end

  describe "show" do
    it "shows task details page" do
      get :show, {"id"=>"#{@task.id}", "project_id"=> "#{@project.id}"}
      expect(assigns(:project)).to eq(@project)
      expect(assigns(:task)).to eq(@project.tasks.last)
      expect(assigns(:comments)).to eq(@task.comments)
      expect(assigns(:comment)).to be_a_new(Comment)
    end
  end

  describe "edit" do
    it "opens a edit page for clicked on task - current user access" do
      get :edit, {"id"=> "#{@task.id}", "project_id"=> "#{@project.id}"}
      expect(assigns(:project).id).to be(@project.id)
    end
  end

  describe "update" do
    it "updates a task as requested from current user if not render edit" do
      patch :update, {"id"=> "#{@task.id}","task"=>{description: "Test Description", checkbox: false, due_date: Time.now.utc + 3600, project_id: "#{@project.id}"}, "project_id"=> "#{@project.id}"}
      expect(assigns(:task)).to eq(Task.last)
      expect(response.status).to eq(302)
    end
  end

  describe "update" do
    it "does not update task if requested from non current user" do
      patch :update, {"id"=> "#{@task.id}","task"=>{description: nil, checkbox: false, due_date: Time.now.utc + 3600, project_id: "#{@project.id}"}, "project_id"=> "#{@project.id}"}
      expect(assigns(:task)).to eq(Task.last)
      expect(assigns(:project)).to eq(@project)
      expect(response.status).to eq(200)
    end
  end

  describe "destroy" do
    it "deletes a single task and all associated data, if not renders show" do
      delete :destroy, {"id"=> "#{@task.id}","task"=>{description: nil, checkbox: false, due_date: Time.now.utc + 3600, project_id: "#{@project.id}"}, "project_id"=> "#{@project.id}"}
      expect(assigns(:project)).to eq(@project)
      expect(nil).to eq(Task.last)
      expect {Task.find(@task.id)}.to raise_error
      expect {Task.find_by(:project_id, @project.id)}.to raise_error
      expect(response.status).to eq(302)
    end
  end

end
