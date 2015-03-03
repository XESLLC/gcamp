require 'rails_helper'

describe "User Model" do
  it "must have a first_name, last_name, email and password" do
    new_user = User.new({first_name: nil, last_name: nil, email: nil, password: nil})
    expect(new_user.save).to be (false)
    new_user = User.new({first_name: "Slovodan", last_name: nil, email: nil, password: nil})
    expect(new_user.save).to be (false)
    new_user = User.new({first_name: "Slovodan", last_name: "Melosovic", email: nil, password: nil})
    expect(new_user.save).to be (false)
    new_user = User.new({first_name: "Slovodan", last_name: "Melosovic", email: "cool@names.com", password: nil})
    expect(new_user.save).to be (false)
    new_user = User.new({first_name: "Slovodan", last_name: "Melosovic", email: "cool@names.com", password: "password"})
    expect(new_user.save).to be (true)
  end
end

describe "Task Model" do
  it "must have a description" do
    new_task = Task.new({description: nil})
    expect(new_task.save).to be (false)
    new_task = Task.new({description: "Kill Slovodan Melosovic"})
    expect(new_task.save).to be (true)
  end
end

describe "Project Model" do
  it "must have a name" do
    new_task = Project.new({name: nil})
    expect(new_task.save).to be (false)
    new_task = Project.new({name: "Find Slovodan's Weapons"})
    expect(new_task.save).to be (true)
  end
end
