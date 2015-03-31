feature "Check membership pages w flash and validations" do
  before do
    seed_test_with_user_project_membership
    @task = create_task
    sign_in_user1
    visit project_memberships_path(@project.id)
  end

  scenario "Admin & User can see index page" do
    expect(page).to have_content ("owner")
    expect(page).to have_content ("member")
    expect(page).to have_content ("Manage Members")
    sign_in_admin
    visit project_memberships_path(@project.id)
    expect(page).to have_content ("owner")
    expect(page).to have_content ("member")
    expect(page).to have_content ("Manage Members")
  end

  scenario "Owners can edit membership detials & delete" do
    within("table.form-group", match: :first) do
      select "member", :from => "membership_role"
      click_on "Update"
    end
    expect(page).to have_content ("was successfully updated.")
    first('.glyphicon').click
    expect(page).to have_content ("successfully removed")
    expect(current_path).to eq("/projects")
  end

  scenario "Admin can edit membership detials & delete" do
    sign_in_admin
    visit project_memberships_path(@project.id)
    within("table.form-group", match: :first) do
      select "member", :from => "membership_role"
      click_on "Update"
    end
    expect(page).to have_content ("was successfully updated.")
    first('.glyphicon').click
    expect(page).to have_content ("successfully removed")
  end

end
