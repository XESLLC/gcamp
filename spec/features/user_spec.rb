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
      new_user = User.new({first_name: "Slovodan", last_name: "Melosovic", email: "cool@names.com", password: "password", password_confirmation: "password"})
      new_user.save
      visit users_path
      click_on ("Slovodan Melosovic")
      expect(page).to have_content ("Slovodan")
      expect(page).to have_content ("Melosovic")
      expect(page).to have_content ("cool@names.com")
      expect(page).to have_content ("User")
      expect(current_path).to eq("/users/#{new_user[:id]}")
    end

    scenario "users can edit users detials except password" do
      new_user = User.new({first_name: "Slovodan", last_name: "Melosovic", email: "cool@names.com", password: "password", password_confirmation: "password"})
      new_user.save
      visit "/users/#{new_user[:id]}"
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
      new_user = User.new({first_name: "Slovodan", last_name: "Melosovic", email: "cool@names.com", password: "password"})
      new_user.save
      visit "/users/#{new_user[:id]}"
      click_on ("Edit")
      click_on ("Delete User")
      expect(page).to have_content ("User was successfully deleted.")
      expect(page).to have_no_content ("Slovadon Melosovic")
      expect(current_path).to eq("/")
    end
end
