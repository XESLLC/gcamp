def sign_up
  visit signup_path
  within(".form-horizontal") do
    click_on("Sign Up")
  end
  fill_in "First Name", with: "Con"
  fill_in "Last Name", with: "Queso"
  fill_in "Email", with: "cheese@melted.com"
  fill_in "Password", with: "password"
  fill_in "Password Confirmation", with: "password"
  within(".form-horizontal") do
    click_on("Sign Up")
  end
end

def sign_in_user1
  visit signin_path
  fill_in "Email", with: "email@email.com"
  fill_in "Password", with: "password"
  within(".form-horizontal") do
    click_on("Sign In")
  end
end

def sign_in_admin
  click_on("Sign Out")
  click_on("Sign In")
  User.create!(first_name: "admin", last_name: "admin", email: "admin@example.com", password: "password", admin: true)
  fill_in "Email", with: "admin@example.com"
  fill_in "Password", with: "password"
  within(".form-horizontal") do
    click_on("Sign In")
  end
end

def sign_up2
  visit signup_path
  within(".form-horizontal") do
    click_on("Sign Up")
  end
  fill_in "First Name", with: "The"
  fill_in "Last Name", with: "Best"
  fill_in "Email", with: "best@stuff.com"
  fill_in "Password", with: "password"
  fill_in "Password Confirmation", with: "password"
  within(".form-horizontal") do
    click_on("Sign Up")
  end
end

def create_admin
  User.create!(first_name: "Admin", last_name: "Admin", email: "admin@email.com", password: "password", admin: true)
end

def seed_test_with_user_project_membership
  unless User.first
  @user1 =  User.create!(first_name: "Slovodan", last_name: "Melosovic", email: "email@email.com", password: "password", token: "986eb53247fa846e8eef7cbcb8c93203")
  @user2 =  User.create!(first_name: "Billy", last_name: "Bob", email: "billy@email.com", password: "password")
  @user3 =  User.create!(first_name: "Sue", last_name: "Smith", email: "sue@email.com", password: "password")
  end
  @project = Project.create!({name: "Find Slovodan's Weapons"})
  Membership.create!(role: 1, project_id: @project.id, user_id: @user1.id)
  Membership.create!(role: 1, project_id: @project.id, user_id: @user2.id)
  Membership.create!(role: 2, project_id: @project.id, user_id: @user3.id)
  @project
end


def create_new_project2
  user =User.create!(first_name: "Boris", last_name: "Yeltsin", email: "Yelstsin@email.com", password: "password")
  project = Project.create!({name: "Find Russia's Weapons"})
  Membership.create!(role: 1, project_id: project.id, user_id: user.id)
  project
end

def create_task
  task = Task.create!(description: "Kill Slovodan Melosovic", checkbox: false, due_date: Time.now.utc + 3600, project_id: "#{@project.id}")
  Comment.create!(user_id: @user1.id, task_id: task.id, comment: "Test Comment")
  task
end

RSpec.configure do |config|

  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
  end

  config.before(:each, :js => true) do
    DatabaseCleaner.strategy = :truncation
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end

end
