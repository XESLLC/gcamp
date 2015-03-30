class UsersController < PagesController

  before_action :user_logged_in
  before_action :check_if_proper_user, only: [:edit, :update, :destroy]
  before_action :check_other_members, only: :index
  before_action :ensure_admin_to_make_admin, only: [:create, :update]

  def index
    @users = User.all
    @members_associated
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to users_path, notice: 'User was successfully created.'
    else
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to users_path, notice: 'User was successfully updated.'
    else
      render :edit
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def destroy
    ensure_admin_to_make_admin
    @user = User.find(params[:id])
    @user.destroy
    redirect_to users_path, notice: 'User was successfully deleted.'
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :admin)
  end

  def check_other_members
    @members_associated = []
    current_user.projects.each do |project|
      project.users.each do |user|
          @members_associated << user.id
      end
    end
  end

end
