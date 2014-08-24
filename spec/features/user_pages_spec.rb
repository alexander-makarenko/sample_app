require 'rails_helper'

feature "Signup page" do
  background     { visit signup_path }
  given(:user)   { FactoryGirl.build(:user) }
  
  scenario "when visiting the page" do
    expect(page).to have_h1_header 'Sign up'
    expect(page).to have_proper_title_for :signup_page
  end

  scenario "when submitting invalid data" do
    expect { invalid_signup }.not_to change(User, :count)
    expect(page).to have_error_message('error')
  end

  scenario "when submitting valid data" do
    expect { valid_signup(user) }.to change(User, :count).by(1)

    newly_created_user = User.find_by(email: user.email)

    expect(page).to have_title(newly_created_user.name)
    expect(page).to have_link('Sign out')
    expect(page).to have_success_message('Welcome')

    visit current_path # reload the page
    expect(page).not_to have_success_message('Welcome')
  end
end

feature "User profile page" do
  given(:user) { FactoryGirl.create(:user) }
  background   { visit user_path(user) }

  scenario "when visiting the page" do
    expect(page).to have_title(user.name)
    expect(page).to have_content(user.name)
  end
end