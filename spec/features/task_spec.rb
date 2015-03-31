feature "Check tasks pages w flash and validations" do
  before do
    seed_test_with_user_project_membership
    sign_in_user1
    @task = create_task
    visit project_tasks_path(@project)

  end

  scenario "User can see index page" do
    expect(page).to have_content ("Tasks")
    expect(page).to have_content ("Description")
    expect(page).to have_content ("Due Date")

  end

  scenario "User can create new task" do
    click_on('New Task')
    expect(page).to have_content ("New Task")
    fill_in "Description", with: nil
    click_on ("Create Task")
    expect(page).to have_content ("1 error prohibited this article from being saved:")
    expect(page).to have_content ("Description can't be blank")
    fill_in "Description", with: "Kill Slovodan Melosovic"
    fill_in "Due date", with: 01012015
    click_on ("Create Task")
    expect(page).to have_content ("Task was successfully created.")
    expect(page).to have_content ("Kill Slovodan Melosovic")

  end

  scenario "User can see specific task details" do
    click_on ("Kill Slovodan Melosovic")
    expect(page).to have_content ("Kill Slovodan Melosovic")
    expect(page).to have_content ("Due on")
    expect(current_path).to eq("/projects/#{@project.id}/tasks/#{@task.id}")
  end

  scenario "User can edit tasks detials" do
    visit ("/projects/#{@project.id}/tasks/#{@task.id}")
    click_on ("Edit")
    expect(page).to have_content ("Edit Task")
    fill_in "Description", with: nil
    fill_in "Due date", with: nil
    click_on ("Update Task")
    expect(page).to have_content ("1 error prohibited this article from being saved:")
    expect(page).to have_content ("Description can't be blank")
    fill_in "Description", with: "Kill Slovodan Melosovic again"
    fill_in "Due date", with: "01012015"
    click_on ("Update Task")
    expect(page).to have_content ("Task was successfully updated.")
    expect(current_path).to eq("/projects/#{@project.id}/tasks/#{@task.id}")
  end

  scenario "User can delete task" do

    visit ("/projects/#{@project.id}/tasks")
    find('.glyphicon-remove').click

    expect(page).to have_content ("Task was successfully deleted.")
    expect(page).to have_no_content ("Kill Slovodan Melosovic")
    expect(current_path).to eq("/projects/#{@project.id}/tasks")
  end
end
