describe MembershipsController do
  before do
    @user = create_user
    @project = create_new_project
    session[:user_id] = @user.id
  end

  describe "index" do
    it "shows all memberships for current user only" do
      get :index, project_id: @project.id
      expect(response).to render_template("index")
      expect(assigns(:project).id).to eq(@project.id)
      expect(assigns(:membership)).to be_a_new(Membership)
      expect(assigns(:memberships)).to eq(@project.memberships.all)
      expect(assigns(:users)).to eq(User.all)
    end
  end

  describe "create" do
    it "saves new user and makes current user the owner" do
      post :create, {"project_id"=>"#{@project.id}","membership"=>{"role"=>"1", "user_id"=> "#{@user.id}", "project_id"=> "#{@project.id}"}}
      expect(assigns(:project).id).to eq(@project.id)
      expect(assigns(:membership).user_id).to eq(@user.id)
      expect(assigns(:memberships)).to eq(@project.memberships.all)
      expect(response.status).to eq(302)
    end
  end

  describe "update" do
    it "updates a user as requested from current user" do
      post :create, {"project_id"=>"#{@project.id}","membership"=>{"role"=>"1", "user_id"=> "#{@user.id}", "project_id"=> "#{@project.id}"}}
      expect(assigns(:project).id).to eq(@project.id)
      expect(assigns(:membership).user_id).to eq(@user.id)
      expect(assigns(:memberships)).to eq(@project.memberships.all)
      expect(response.status).to eq(302)
    end
  end

  describe "update" do
    it "does not allow last owner to change" do
      patch :update, {"project_id"=>"#{@project.id}", "id"=>"#{@project.memberships.last.id}", "membership"=>{"role"=>"2", "user_id"=> "#{@user.id}", "project_id"=> "#{@project.id}"}}
      expect(assigns(:owner_count)).to eq(1)
      expect(response.status).to eq(302)
    end
  end

  describe "destroy" do
    it "attempts to deletes the only owner memberships" do
      delete :destroy, {"project_id"=>"#{@project.id}", "id"=>"#{@project.memberships.last.id}", "membership"=>{"role"=>"2", "user_id"=> "#{@user.id}", "project_id"=> "#{@project.id}"}}
      expect(assigns(:project)).to eq(@project)
      expect(nil).to eq(@project.memberships.last)
      expect(response.status).to eq(302)
    end
  end

end
