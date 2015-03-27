describe ProjectsController do
  before do
    @user = create_user
    @project = create_new_project
    session[:user_id] = @user.id
  end

  describe "index" do
    it "shows all projects for current user only" do
      get :index
      expect(response).to render_template("index")
      expect(assigns(:projects)).to eq([@project])
    end
  end

  describe "new" do
    it "shows a new project page" do
      get :new
      expect(assigns(:project)).to be_a_new(Project)
    end
  end

  describe "create" do
    it "saves new project and makes current user the owner" do
      post :create, {"project"=>{"name"=>"Hey Hey Hey"}}
      expect(assigns(:project).name).to eq("Hey Hey Hey")
      expect(Project.last.name).to eq("Hey Hey Hey")
      expect(Project.last.memberships.last.project_id).to eq(assigns(:project).id)
      expect(response.status).to eq(302)
    end
  end

  describe "create" do
    it "does not save new project and renders new" do
      get :create, {"project"=>{"name"=>nil}}
      expect(response.status).to eq(200)
    end
  end

  describe "edit" do
    it "opens a edit page for clicked on project - current user access" do
      get :edit, {"id"=>@project.id}
      expect(assigns(:project).id).to be(@project.id)
    end
  end

  describe "update" do
    it "updates a project as requested from current user if not render edit" do
      patch :update, {"project"=>{"name"=>"Davids First Project 1"}, "id"=>@project.id}
      expect(assigns(:project).name).to eq("Davids First Project 1")
      expect(Project.find(@project.id).name).to eq("Davids First Project 1")
      expect(response.status).to eq(302)
    end
  end

  describe "udate" do
    it "does not update new project and renders new" do
      patch :create, {"project"=>{"name"=>nil}}
      expect(response.status).to eq(200)
    end
  end

  describe "show" do
    it "opens a page to show just a single project details" do
      create_new_project_task
      get :show, {"id"=>@project.id}
      expect(assigns(:project)).to eq(@project)
      expect(Project.last.tasks.count).to eq(assigns(:task_count))
      expect(response.status).to eq(200)
    end
  end

  describe "destroy" do
    it "deletes a single project and all associated data, if not renders show" do
      delete :destroy, {"id"=>@project.id}
      expect(assigns(:project)).to eq(@project)
      expect { Project.find(@project.id) }.to raise_error
      expect {Task.find_by(:project_id, @project.id)}.to raise_error
      expect(response.status).to eq(302)
    end
  end

end
