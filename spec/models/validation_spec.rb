require 'rails_helper'

describe "User Model" do
  it "must have a first_name, last_name, and email" do
    new_user = User.new({first_name: nil, last_name: nil, email: nil})
    expect(new_user.save).to be (false)
    new_user = User.new({first_name: "Slovodan", last_name: nil, email: nil})
    expect(new_user.save).to be (false)
    new_user = User.new({first_name: "Slovodan", last_name: "Melosovic", email: nil})
    expect(new_user.save).to be (false)
    new_user = User.new({first_name: "Slovodan", last_name: "Melosovic", email: "cool@names.com"})
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
