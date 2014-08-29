require 'rails_helper'

feature "Sign in and out" do
  given(:user) { create :user }
  background   { visit signin_path }

  scenario "when visiting the signin page" do
    expect(page).to have_h1_header 'Sign in'
    expect(page).to have_title_expected_for :signin_page
  end

  scenario "when signing in with invalid data" do
    fail_to_sign_in

    expect(page).to have_title_expected_for :signin_page
    expect(page).not_to have_link 'Users'
    expect(page).not_to have_link 'Profile'
    expect(page).not_to have_link 'Settings'
    expect(page).not_to have_link 'Sign out'
    expect(page).to have_error_message 'Invalid'

    click_link 'Home'
    expect(page).not_to have_error_message 'Invalid'
  end

  scenario "when signing in with valid data" do
    sign_in user
  
    expect(page).to have_title(user.name)
    expect(page).to have_link 'Users',       href: users_path
    expect(page).to have_link 'Profile',     href: user_path(user)
    expect(page).to have_link 'Settings',    href: edit_user_path(user)
    expect(page).to have_link 'Sign out',    href: signout_path
    expect(page).not_to have_link 'Sign in', href: signin_path

    click_link 'Home'
    expect(page).not_to have_link 'Sign up now!'
  end

  scenario "when signing out" do
    sign_in user

    click_link 'Sign out'
    expect(page).to have_link 'Sign in'
  end
end

feature "Authorization" do
  given(:user) { create :user }
  
  scenario "when a non-signed-in user visits the user edit page" do
    visit edit_user_path(user)
    expect(page).to have_title_expected_for :signin_page
  end

  scenario "when a signed-in user tries to access another user's edit page" do
    wrong_user = create :user, email: 'wrong@example.com'
    
    visit signin_path
    sign_in user

    visit edit_user_path(wrong_user)
    expect(page).not_to have_title_expected_for :edit_user_page
    expect(page).to have_title_expected_for :home_page
  end

  scenario "after a non-signed-in user visiting his edit page signs in" do
    visit edit_user_path(user)
    sign_in user
    expect(page).to have_title_expected_for :edit_user_page

    click_link 'Sign out'
    click_link 'Sign in'
    sign_in user
    expect(page).to have_title(user.name)
   end

  scenario "when a signed-in user visits the signup page" do
    visit signin_path
    sign_in user

    visit signup_path
    expect(page).not_to have_title_expected_for :signup_page
    expect(page).to have_title_expected_for :home_page
  end

  scenario "when a non-signed-in user tries to see the users index" do
    visit users_path
    expect(page).to have_title_expected_for :signin_page
  end

  scenario "when a signed in user visits the users index page" do
    30.times { create :user }
    visit signin_path
    sign_in user
    visit users_path

    expect(page).to have_h1_header 'All users'
    expect(page).to have_title_expected_for :users_index_page
    expect(page).to have_selector 'ul.pagination'
    expect(page).not_to have_link 'delete', href: user_path(User.first)
    
    User.paginate(page: 1).each do |user|
      expect(page).to have_selector 'li', text: user.name
    end
  end

  scenario "when a signed-in admin user visits the users index page" do
    user  = create :user
    admin = create :admin
    visit signin_path
    sign_in admin
    visit users_path

    expect(page).to     have_link 'delete', href: user_path(user)
    expect(page).not_to have_link 'delete', href: user_path(admin)
    expect { click_link 'delete', match: :first }.to change(User, :count).by(-1)
  end
end