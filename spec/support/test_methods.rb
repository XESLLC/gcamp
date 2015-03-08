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


def create_new_project
  Project.create!({name: "Find Slovodan's Weapons"})
end

def create_new_project_task
  Task.create!({
    description: "Kill Slovodan Melosovic",
    checkbox: false,
    due_date: Time.zone.tomorrow,
    project_id: Project.last[:id]
  })
end
