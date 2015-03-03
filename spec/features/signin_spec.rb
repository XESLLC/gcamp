require 'rails_helper'

feature "Check signin w flash and validations" do
  scenario "Users signin and see root" do
    sign_up
    click_on("Sign Out")
    click_on("Sign In")
    fill_in "Email", with: "cheese@melted.com"
    fill_in "Password", with: "password"
    within(".form-horizontal") do
      click_on("Sign In")
    end
    expect(page).to have_content("You have successfully signed in")
    expect(current_path).to eq(root_path)
  end
end
