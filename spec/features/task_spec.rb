feature "Check tasks pages w flash and validations" do
  before do
    sign_up
    @project_test = create_new_project
    @task_test = create_new_project_task
    visit project_tasks_path(@project_test)
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
    new_task =
    click_on ("Create Task")
    expect(page).to have_content ("Task was successfully created.")
    expect(page).to have_content ("Kill Slovodan Melosovic")

  end

  scenario "User can see specific task details" do
    click_on ("Kill Slovodan Melosovic")
    expect(page).to have_content ("Kill Slovodan Melosovic")
    expect(page).to have_content ("Due date")
    expect(current_path).to eq("/projects/#{@project_test.id}/tasks/#{@task_test.id}")
  end

  scenario "User can edit tasks detials" do
    visit ("/projects/#{@project_test.id}/tasks/#{@task_test.id}")
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
    expect(current_path).to eq("/projects/#{@project_test.id}/tasks/#{@task_test.id}")
  end

  scenario "User can delete task" do

    visit ("/projects/#{@project_test.id}/tasks")
    find(:xpath, "//tr[contains(.,'Kill Slovodan Melosovic')]/td/div/a", :text => 'Delete').click
    expect(page).to have_content ("Task was successfully deleted.")
    expect(page).to have_no_content ("Kill Slovodan Melosovic")
    expect(current_path).to eq("/projects/#{@project_test.id}/tasks")
  end
end
