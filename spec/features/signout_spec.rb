
feature "Check signout w flash and validations" do
  scenario "Users signout and see root" do
    sign_up
    click_on("Sign Out")
    expect(page).to have_content("You have successfully signed out")
    expect(current_path).to eq(root_path)
  end
end
