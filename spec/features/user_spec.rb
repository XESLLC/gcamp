feature "Check users pages w flash and validations" do
  before do
    sign_up
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

    scenario "users can see specific user details" do
      visit "/users"
      first(:link, "Con Queso").click
      expect(page).to have_content ("Con")
      expect(page).to have_content ("Queso")
      expect(page).to have_content ("cheese@melted.com")
      expect(page).to have_content ("User")
      expect(current_path).to eq("/users/#{User.first[:id]}")
    end

    scenario "users can edit only thier detials except password" do
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
    end

    scenario "users can delete user" do
      visit "/users"
      click_on ("Edit")
      click_on ("Delete User")
      expect(page).to have_content ("You must sign in")
      expect(page).to have_no_content ("Slovadon Melosovic")
      expect(current_path).to eq("/")
    end
end
