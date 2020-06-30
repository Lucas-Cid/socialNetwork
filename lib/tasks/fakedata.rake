namespace :fakedata do
  desc "Generate fake users with fake posts."
  task create: :environment do
    i = 0
    f = File.new('emails.txt', 'w')

    puts "Refer to the 'Emails.txt' file to see all the emails. All users have '123456' as password"
    puts "Generating fake users and posts, please wait..."
    t = Time.now

    while i < 100 do
      begin
        user = User.new(
            :name => Faker::Name.first_name + " " + Faker::Name.last_name,
            :username => "@" + Faker::Internet.username(specifier: 5..13).sub(".", "_"),
            :email => Faker::Internet.email,
            :password => '123456'
        )
        user.save!

        f << "#{user.email} #{user.username} #{user.name}\n"

        10.times {
          post = Post.new(
              :content => Faker::Lorem.paragraph_by_chars(number: 180),
              :user => user
          )

          post.save!
        }

        i += 1
        puts "User with ID #{user.id} is ready. #{100 - i} to go."

      rescue
        next
      end
    end

    puts "Task finished after #{(Time.now - t).to_i} seconds"
    puts "Done!\n"
  end

  desc "Delete all posts and users"
  task reset: :environment do

    puts "Deleting all posts and users. This might take a while...\n"
    t = Time.now
    total_posts = Post.all.size
    total_users = User.all.size
    i = 0

    Post.all.each do |p|
      p.destroy!

      puts "Deleting posts. #{total_posts - i} to go."
      i += 1
    end

    i = 0

    User.all.each do |u|
      u.destroy!

      puts "Deleting users. #{total_users - i} to go."
      i += 1
    end

    puts "Task finished after #{(Time.now - t).to_i} seconds"
    puts "Done!\n"
  end

end
