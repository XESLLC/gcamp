namespace :admin do
  desc "Make First Admin"
  task make_admin: :environment do

    User.all.each do |user|
      @no_of_admins = 0
      if user.admin == true
        @no_of_admins += 1
      end
    end

    user = ["none"]
    if @no_of_admins < 1
      @user = User.create!(first_name: "admin", last_name: "admin", email: "admin@example.com", password: "password", admin: true)
    end

    puts "-"*100
    puts "Number of Admins #{@no_of_admins}"
    puts "New admin email: admin@example.com and password: password"


  end
end
