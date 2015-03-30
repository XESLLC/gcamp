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

def create_new_project
  unless User.first
    User.create!(first_name: "Slovodan", last_name: "Melosovic", email: "email@email.com", password: "password")
  end
  project = Project.create!({name: "Find Slovodan's Weapons"})
  user_test = User.first
  Membership.create!(role: 1, project_id: project.id, user_id: user_test.id)
  project
end

def create_new_project_task
  Task.create!({
    description: "Kill Slovodan Melosovic",
    checkbox: false,
    due_date: Time.zone.tomorrow,
    project_id: Project.find_by(name: "Find Slovodan's Weapons").id
  })
end

def create_user
  User.create!(first_name: "Slovodan", last_name: "Melosovic", email: "email@email.com", password: "password")
end

def create_task
  task = Task.create!(description: "Test Description", checkbox: false, due_date: Time.now.utc + 3600, project_id: "#{@project.id}")
  Comment.create!(user_id: User.last, task_id: task.id, comment: "Test Comment")
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
