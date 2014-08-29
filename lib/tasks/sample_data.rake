namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    admin = User.create!(name: "John Smith",
                         email: "john.smith@example.com",
                         password: "asdf123",
                         password_confirmation: "asdf123",
                         admin: true)

    100.times do |n|
      name     = Faker::Name.name
      email    = Faker::Internet.safe_email
      password = Faker::Internet.password(8, 14)
      User.create!(name: name,
                   email: email,
                   password: password,
                   password_confirmation: password)
    end
  end
end