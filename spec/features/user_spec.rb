
feature "Check users pages w flash and validations" do
  before do
    seed_test_with_user_project_membership
    sign_in_user1
  end
    scenario "Users can see index page" do
      visit users_path
      expect(page).to have_content ("Users")
      expect(page).to have_content ("New User")
      expect(page).to have_content ("Name")
      expect(page).to have_content ("Email")
    end

    scenario "Users can create new user" do
      visit users_path
      click_on("New User")
      expect(page).to have_content ("New User")
      fill_in "user_first_name", with: nil
      fill_in "user_last_name", with: nil
      fill_in "user_email", with: nil
      fill_in "user_password", with: nil
      click_on ("Create User")
      expect(page).to have_content ("4 errors prohibited this article from being saved:")
      expect(page).to have_content ("First name can't be blank")
      expect(page).to have_content ("Last name can't be blank")
      expect(page).to have_content ("Email can't be blank")
      expect(page).to have_content ("Password can't be blank")
      fill_in "user_first_name", with: "Slovodan"
      fill_in "user_last_name", with: "Melosovic"
      fill_in "user_email", with: "email@fake.com"
      fill_in "user_password", with: "password"
      fill_in "user_password_confirmation", with: "password"
      click_on ("Create User")
      expect(page).to have_content ("User was successfully created.")
      expect(current_path).to eq("/users")
    end

    scenario "users and admins can see specific user details" do
      visit "/users"
      first(:link, "Slovodan Melosovic").click
      expect(page).to have_content ("Slovodan")
      expect(page).to have_content ("Melosovic")
      expect(page).to have_content ("email@email.com")
      expect(page).to have_content ("User")
      expect(current_path).to eq("/users/#{@user1[:id]}")
      sign_in_admin
      visit "/users"
      click_on("#{User.first.full_name}")
      expect(page).to have_content ("email@email.com")
    end

    scenario "users and admins can edit only thier detials except password - others cant" do
      visit "/users"
      click_on ("Edit")
      expect(page).to have_content ("Edit User")
      fill_in "user_first_name", with: nil
      fill_in "user_last_name", with: nil
      fill_in "user_email", with: nil
      click_on ("Update User")
      expect(page).to have_content ("3 errors prohibited this article from being saved:")
      expect(page).to have_content ("First name can't be blank")
      expect(page).to have_content ("Last name can't be blank")
      expect(page).to have_content ("Email can't be blank")
      fill_in "user_first_name", with: "Slovodany"
      fill_in "user_last_name", with: "Melosovicy "
      fill_in "user_email", with: "email@fake.com"
      click_on ("Update User")
      expect(page).to have_content ("User was successfully updated.")
      expect(current_path).to eq("/users")
      sign_up2
      visit "/users"
      click_on ("Edit")
      expect(page).to have_content ("Delete User")
      sign_in_admin
      visit "/users"
      click_on("#{User.second.full_name}")
      click_on ("Edit")
      expect(page).to have_content ("Delete User")
    end

    scenario "users can delete user" do
      visit "/users"
      click_on ("Edit")
      click_on ("Delete User")
      expect(current_path).to eq("/users")
      visit "/users"
    end

    scenario "admin can delete user" do
      sign_in_admin
      visit "/users"
      click_on("#{@user1.full_name}")
      click_on ("Edit")
      expect(page).to have_content ("Delete User")
      click_on ("Delete User")
      expect(current_path).to eq("/users")
    end


end
