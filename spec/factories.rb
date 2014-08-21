FactoryGirl.define do
  factory :user do
    name     'John Smith'
    email    'john.smith@email.com'
    password 'asdf123'
    password_confirmation 'asdf123'
  end
end