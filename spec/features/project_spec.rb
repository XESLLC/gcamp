

feature "Check projects pages w flash and validations" do
  before do
    sign_up
  end
    scenario "Users can see project index page" do
      visit projects_path
      expect(page).to have_content ("Projects")
      expect(page).to have_content ("New Project")
      expect(page).to have_content ("Name")
      end

    scenario "Users can create new project" do
      visit projects_path
      find('.btn').click
      expect(page).to have_content ("New Project")
      fill_in "project_name", with: nil
      click_on ("Create Project")
      expect(page).to have_content ("1 error prohibited this article from being saved:")
      expect(page).to have_content ("Name can't be blank")
      fill_in "project_name", with: "Find Slovodan's Weapons"
      click_on ("Create Project")
      expect(page).to have_content ("Project was successfully created.")
    end

    scenario "Users can see specific project details" do
      new_project = Project.new({name: "Find Slovodan's Weapons"})
      new_project.save
      visit projects_path
      click_on ("Find Slovodan's Weapons")
      expect(page).to have_content ("Find Slovodan's Weapons")
      expect(page).to have_content ("Project")
      expect(current_path).to eq("/projects/#{new_project[:id]}")
    end

    scenario "Users can edit projects detials" do
      new_project = Project.new({name: "Find Slovodan's Weapons"})
      new_project.save
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
      new_project = Project.new({name: "Find Slovodan's Weapons"})
      new_project.save
      visit ("/projects/#{new_project[:id]}_path")
      click_on ("Delete")
      expect(page).to have_content ("Project was successfully deleted.")
      expect(page).to have_no_content ("Find Slovodan's Weapons")
      expect(current_path).to eq("/projects")
    end
end
