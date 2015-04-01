
feature "Check signup page w flash and validations" do
    scenario "Users can see signup page" do
      visit signup_path
      expect(page).to have_content ("Sign up for gCamp!")
      expect(page).to have_content ("First Name")
      expect(page).to have_content ("Last Name")
      expect(page).to have_content ("Email")
      expect(page).to have_content ("Password")
      expect(page).to have_content ("Password Confirmation")
      end

    scenario "Users can signup" do
      visit signup_path
      within(".form-horizontal") do
        click_on("Sign Up")
      end
      expect(page).to have_content ("Sign up for gCamp!")
      expect(page).to have_content ("First name can't be blank")
      expect(page).to have_content ("Last name can't be blank")
      expect(page).to have_content ("Email can't be blank")
      expect(page).to have_content ("Password can't be blank")
      fill_in "First Name", with: "Con"
      fill_in "Last Name", with: "Queso"
      fill_in "Email", with: "cheese@melted.com"
      fill_in "Password", with: "password"
      fill_in "Password Confirmation", with: "password"
      within(".form-horizontal") do
        click_on("Sign Up")
      end
      expect(page).to have_content ("You have successfully signed up")
      expect(current_path).to eq(new_project_path)
    end
end
