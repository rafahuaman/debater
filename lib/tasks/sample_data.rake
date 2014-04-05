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
    
    users = User.all(limit: 6)
    50.times do
      title = Faker::Lorem.sentence(5)
      content = Faker::Lorem.sentence(10)
      affirmative = Faker::Lorem.sentence(5)
      negative = Faker::Lorem.sentence(5)
      users.each { |user| user.debates.create!(title: title, content: content, affirmative: affirmative, negative: negative) }
    end
    Chamber.create!(name: "Politics",
      description: "Politics discussions"      
      )
    Chamber.create!(name: "Technology",
      description: "Technology discussions"      
      )
  end
end