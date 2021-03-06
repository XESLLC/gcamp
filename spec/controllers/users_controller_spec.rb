describe UsersController do
  before do
    seed_test_with_user_project_membership
    session[:user_id] = @user1.id
  end

  describe "index" do
    it "shows all users for current user only" do
      get :index
      expect(response).to render_template("index")
      expect(assigns(:users)).to eq([@user1, @user2, @user3])
    end
  end

  describe "new" do
    it "shows a new user page" do
      get :new
      expect(assigns(:user)).to be_a_new(User)
    end
  end

  describe "create" do
    it "saves new user and makes current user the owner" do
      post :create, {"user"=> {"first_name"=>"David", "last_name"=>"Abramowitz", "email"=>"dea@dea2.com", "password"=>"password", "password_confirmation"=>"password"}}
      expect(assigns(:user).last_name).to eq("Abramowitz")
      expect(User.last.last_name).to eq("Abramowitz")
      expect(response.status).to eq(302)
    end
  end

  describe "create" do
    it "does not save new user and renders new" do
      get :create, {"user"=>{"last_name"=>nil}}
      expect(response.status).to eq(200)
    end
  end

  describe "edit" do
    it "opens a edit page for clicked on user - current user access" do
      get :edit, {"id"=>@user1.id}
      expect(assigns(:user).id).to be(@user1.id)
    end
  end

  describe "update" do
    it "updates a user as requested from current user if not render edit" do
      put :update, {"user"=> {"first_name"=>"David", "last_name"=>"Abramowitz", "email"=>"dea@dea2.com", "password"=>"password", "password_confirmation"=>"password"}, "id"=>@user1.id }
      expect(assigns(:user).last_name).to eq("Abramowitz")
      expect(User.find(@user1.id).last_name).to eq("Abramowitz")
      expect(response.status).to eq(302)
    end
  end

  describe "update" do
    it "does not update new user and renders new" do
      patch :create, {"user"=>{"last_name"=>nil}}
      expect(response.status).to eq(200)
    end
  end

  describe "show" do
    it "opens a page to show just a single project details" do
      get :show, {"id"=>@user1.id}
      expect(assigns(:user)).to eq(@user1)
      expect(response.status).to eq(200)
    end
  end

  describe "destroy" do
    it "deletes a single user and all associated data, if not renders show" do
      delete :destroy, {"id"=>@user1.id}
      expect(assigns(:user)).to eq(@user1)
      expect { User.find(@user1.id) }.to raise_error
      expect(response.status).to eq(302)
    end
  end

end
