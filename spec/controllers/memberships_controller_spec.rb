describe MembershipsController do
  before do
    seed_test_with_user_project_membership
    session[:user_id] = @user1.id
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
      post :create, {"project_id"=>"#{@project.id}","membership"=>{"role"=>"1", "user_id"=> "#{@user1.id}", "project_id"=> "#{@project.id}"}}
      expect(assigns(:project).id).to eq(@project.id)
      expect(assigns(:membership).user_id).to eq(@user1.id)
      expect(assigns(:memberships)).to eq(@project.memberships.all)
      expect(response.status).to eq(302)
    end
  end

  describe "update" do
    it "updates a user as requested from current user" do
      post :create, {"project_id"=>"#{@project.id}","membership"=>{"role"=>"1", "user_id"=> "#{@user1.id}", "project_id"=> "#{@project.id}"}}
      expect(assigns(:project).id).to eq(@project.id)
      expect(assigns(:membership).user_id).to eq(@user1.id)
      expect(assigns(:memberships)).to eq(@project.memberships.all)
      expect(response.status).to eq(302)
    end
  end

  describe "update" do
    it "allow owner to change" do
      patch :update, {"project_id"=>"#{@project.id}", "id"=>"#{@project.memberships.last.id}", "membership"=>{"role"=>"2", "user_id"=> "#{@user1.id}", "project_id"=> "#{@project.id}"}}
      expect(assigns(:owner_count)).to eq(2)
      expect(response.status).to eq(302)
    end
  end

  describe "update" do
    it "dont allow last owner to change" do
      patch :update, {"project_id"=>"#{@project.id}", "id"=>"#{@project.memberships.first.id}", "membership"=>{"role"=>"2", "user_id"=> "#{@user1.id}", "project_id"=> "#{@project.id}"}}
      patch :update, {"project_id"=>"#{@project.id}", "id"=>"#{@project.memberships.second.id}", "membership"=>{"role"=>"2", "user_id"=> "#{@user2.id}", "project_id"=> "#{@project.id}"}}
      expect(Membership.all.to_a.count {|member| member.role == "1"}).to eq(1)
      expect(response.status).to eq(302)
    end
  end

  describe "destroy" do
    it "attempts to deletes the only owner memberships" do
      delete :destroy, {"project_id"=>"#{@project.id}", "id"=>"#{@project.memberships.last.id}", "membership"=>{"role"=>"2", "user_id"=> "#{@user3.id}", "project_id"=> "#{@project.id}"}}
      expect(assigns(:project)).to eq(@project)
      expect(assigns(:project).memberships.last).to eq(@project.memberships.last)
      expect(response.status).to eq(302)
    end
  end

end
