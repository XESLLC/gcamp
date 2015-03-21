class UsersController < PagesController
  def user_logged_in
    if current_user
    else
      redirect_to signin_path, alert: "You must sign in"
    end
  end

before_action :user_logged_in

  def index

    @users = User.all

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

    @user = User.find(params[:id])
    @user.destroy
    redirect_to root_path, notice: 'User was successfully deleted.'

  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end

end
