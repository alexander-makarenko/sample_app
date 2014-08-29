require 'rails_helper'

feature "Signup page" do
  background   { visit signup_path }
  given(:user) { build :user }
  
  scenario "when visiting the page" do
    expect(page).to have_h1_header 'Sign up'
    expect(page).to have_title_expected_for :signup_page
  end

  scenario "when submitting invalid data" do
    expect { fail_to_sign_up }.not_to change(User, :count)
    expect(page).to have_error_message 'error'
  end

  scenario "when submitting valid data" do
    expect { sign_up user }.to change(User, :count).by(1)

    newly_created_user = User.find_by(email: user.email)

    expect(page).to have_title(newly_created_user.name)
    expect(page).to have_link 'Sign out'
    expect(page).to have_success_message 'Welcome'

    visit current_path # reload the page
    expect(page).not_to have_success_message 'Welcome'
  end
end

feature "User profile page" do
  given(:user) { create :user }
  background   { visit user_path(user) }

  scenario "when visiting the page" do
    expect(page).to have_title(user.name)
    expect(page).to have_content(user.name)
  end
end

feature "Edit user page" do
  given(:user)      { create(:user) }
  given(:new_name)  { 'New name' }
  given(:new_email) { 'new@example.com' }
  background do
    visit signin_path
    sign_in user
    visit edit_user_path(user)
  end
  
  scenario "when visiting the page" do
    expect(page).to have_h1_header 'Update your profile'
    expect(page).to have_title_expected_for :edit_user_page
    expect(page).to have_link 'Change', href: 'http://gravatar.com/emails'
  end

  scenario "when submitting invalid data" do
    fail_to_update_user
    expect(page).to have_error_message 'error'
  end

  scenario "when submitting valid data" do
    update_user(user, with: { name: new_name, email: new_email })

    expect(user.reload.name).to  eq new_name
    expect(user.reload.email).to eq new_email

    expect(page).to have_title(new_name)
    expect(page).to have_success_message 'successfully updated'
    expect(page).to have_link 'Sign out', href: signout_path
  end
end