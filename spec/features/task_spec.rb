require 'rails_helper'

feature "Check tasks pages w fash and validations" do
    scenario "User can see index page" do
      visit tasks_path
      expect(page).to have_content ("Tasks")
      expect(page).to have_link ("New Task")
      expect(page).to have_content ("Description")
      expect(page).to have_content ("Due Date")
    end

    scenario "User can create new task" do
      visit tasks_path
      click_on("New Task")
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
      new_task = Task.new({description: "Kill Slovodan Melosovic", due_date: "01/01/2015".to_date})
      new_task.save
      visit tasks_path
      click_on ("Kill Slovodan Melosovic")
      expect(page).to have_content ("Kill Slovodan Melosovic")
      expect(page).to have_content ("Due date")
      expect(current_path).to eq("/tasks/#{new_task[:id]}")
    end

    scenario "User can edit tasks detials" do
      new_task = Task.new({description: "Kill Slovodan Melosovic", due_date: "01/01/2015".to_date})
      new_task.save
      visit ("/tasks/#{new_task[:id]}_path")
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
      expect(current_path).to eq("/tasks/#{new_task[:id]}")
    end

    scenario "User can delete task" do
      new_task = Task.new({description: "Kill Slovodan Melosovic", due_date: "01/01/2015".to_date})
      new_task.save
      visit ("/tasks")
      find(:xpath, "//tr[contains(.,'Kill Slovodan Melosovic')]/td/div/a", :text => 'Delete').click
      expect(page).to have_content ("Task was successfully deleted.")
      expect(page).to have_no_content ("Kill Slovodan Melosovic")
      expect(current_path).to eq("/tasks")
    end
end
