namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    User.create!(name: "Example",
                 password: "foobar",
                 password_confirmation: "foobar")
    99.times do |n|
      name  = "#{Faker::Name.first_name}#{n+1}"
      password  = "foobar"
      User.create!(name: name,
                   password: password,
                   password_confirmation: password)
    end

    10.times do |n|
      name = "#{Faker::Commerce.department}#{n+1}"
      description = Faker::Lorem.sentence(10)
      Chamber.create!(name: name, description: description)
    end
    
    users = User.all(limit: 6)
    chambers = Chamber.all
    10.times do
      title = Faker::Lorem.sentence(5)
      content = Faker::Lorem.sentence(10)
      affirmative = Faker::Lorem.sentence(5)
      negative = Faker::Lorem.sentence(5)
      users.each do |user| 
        chambers.each do |chamber|
          user.debates.create!(title: title, content: content, affirmative: affirmative, negative: negative, chamber_id: chamber.id) 
        end
      end
    end
  end
end