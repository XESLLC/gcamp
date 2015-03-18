namespace :destroy_orphans do
  desc "Destroy Orphane objects in DB"
  task destroy_orphan_memberships_tasks_projects: :environment do

    project_ids = Project.all.pluck(:id)
    membership_project_ids = Membership.all.pluck(:project_id)

    @count1 = (0)

    membership_project_ids.each do |project_id|
      if !project_ids.include? project_id || !project_id
        membership_to_destroy = Membership.find_by(project_id: project_id)
        if membership_to_destroy.destroy
          puts project_id
          puts " destroyed!"
          @count1 += 1
        else
          puts project_id
          puts "! destroyed (not destroyed!)"
        end
      end
    end

    user_ids = User.all.pluck(:id)
    membership_user_ids = Membership.all.pluck(:user_id)

    membership_user_ids.each do |user_id|
      if !project_ids.include? user_id || !user.id
         membership_to_destroy = Membership.find_by(user_id: user_id)
        if membership_to_destroy.destroy
          puts user_id
          puts " destroyed!"
          @count1 += 1
        else
          puts user_id
          puts "! destroyed (not destroyed!)"
        end
      end
    end

    project_ids = Project.all.pluck(:id)
    task_project_ids = Task.all.pluck(:project_id)

    @count2 = (0)

    task_project_ids.each do |project_id|
      if !project_ids.include? project_id || !project_id
        task_to_destroy = Task.find_by(project_id: project_id)
        if task_to_destroy.destroy
          puts project_id
          puts " destroyed!"
          @count2 += 1
        else
          puts project_id
          puts "! destroyed (not destroyed!)"
        end
      end
    end

    task_ids = Task.all.pluck(:id)
    comment_task_ids = Comment.all.pluck(:task_id)

    @count3 = (0)

    comment_task_ids.each do |task_id|
      if !task_ids.include? task_id || !task_id
        comment_to_destroy = Comment.find_by(task_id: task_id)
        if comment_to_destroy.destroy
          puts task_id
          puts " destroyed!"
          @count3 += 1
        else
          puts task_id
          puts "! destroyed (not destroyed!)"
        end
      end
    end

    user_ids = User.all.pluck(:id)
    comment_task_ids = Comment.all.pluck(:user_id)

    @count4 = (0)

    comment_task_ids.each do |user_id|
      if !user_ids.include? user_id
        comment_to_set_nil = Comment.find_by(user_id: user_id)
        if comment_to_set_nil.update(user_id: nil)
          puts user_id
          puts " set to nil"
          @count4 += 1
        else
          puts user_id
          puts "! set to nil (not set to nil!)"
        end
      end
    end

    puts "-"*100
    puts "-"*100
    puts @count1.to_s + " Membership(s) (no ids) destroyed!"
    puts @count2.to_s + " Task(s) (no ids) destroyed!"
    puts @count3.to_s + " Comment(s) (no ids) destroyed!"
    puts @count3.to_s + " Comment(s) (no users) user ids set to nil!"
    puts (@count1+@count2+@count3+@count4).to_s + " Total Record(s) updated or destroyed!"


  end
end
