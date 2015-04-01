
feature "Check projects pages w flash and validations" do
  before do
    seed_test_with_user_project_membership
    create_new_project2
    sign_in_user1
  end

  scenario "Users can see project index page for only a members project unless a admin" do
    visit projects_path
    expect(page).to have_content ("Projects")
    expect(page).to have_content ("New Project")
    expect(page).to have_content ("Name")
    expect(page).to have_content ("Find Slovodan's Weapons")
    expect(page).to have_no_content ("Find Russia's Weapons")
    visit root_path
    sign_in_admin
    visit projects_path
    expect(page).to have_content ("Projects")
    expect(page).to have_content ("New Project")
    expect(page).to have_content ("Name")
    expect(page).to have_content ("Find Slovodan's Weapons")
    expect(page).to have_content ("Find Russia's Weapons")
    end

  scenario "Users can create new project" do
    visit new_project_path
    fill_in "Name", with: nil
    click_on ("Create Project")
    expect(page).to have_content ("1 error prohibited this article from being saved:")
    expect(page).to have_content ("Name can't be blank")
    fill_in "project_name", with: "Find Slovodan's Weapons"
    click_on ("Create Project")
    expect(page).to have_content ("Project was successfully created.")
  end

  scenario "Users can see specific project details" do
    new_project = Project.create!({name: "New Project Test"})
    Membership.create!(role: 1, project_id: new_project.id, user_id: User.first.id )
    visit projects_path
    first(:link, "New Project Test").click
    expect(page).to have_content ("New Project Test")
    expect(page).to have_content ("Project")
    expect(current_path).to eq("/projects/#{new_project[:id]}")
  end

  scenario "Users can edit projects detials" do
    new_project = Project.create!({name: "Find Slovodan's Weapons"})
    Membership.create!(role: 1, project_id: new_project.id, user_id: @user1.id)
    visit ("/projects/#{new_project[:id]}_path")
    click_on ("Edit")
    expect(page).to have_content ("Edit Project")
    fill_in "project_name", with: nil
    click_on ("Update Project")
    expect(page).to have_content ("1 error prohibited this article from being saved:")
    expect(page).to have_content ("Name can't be blank")
    fill_in "project_name", with: "Find Slovodan's Weapons"
    click_on ("Update Project")
    expect(page).to have_content ("Project was successfully updated.")
    expect(current_path).to eq("/projects/#{new_project[:id]}")
  end

  scenario "Users can delete project" do
    new_project = Project.create!({name: "Deleted Project"})
    Membership.create!(role: 1, project_id: new_project.id, user_id: @user1.id)
    visit ("/projects/#{new_project[:id]}_path")
    click_on ("Delete")
    expect(page).to have_content ("Project was successfully deleted.")
    expect(page).to have_no_content ("Deleted Project")
    expect(current_path).to eq("/projects")
  end

end
