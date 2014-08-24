require 'rails_helper'

feature "Sign in page" do
  background { visit signin_path }
  given(:user) { FactoryGirl.create(:user) }
  
  scenario "when visiting the page" do
    expect(page).to have_h1_header 'Sign in'
    expect(page).to have_proper_title_for :signin_page
  end

  scenario "when submitting invalid data" do
    invalid_signin

    expect(page).to have_proper_title_for :signin_page
    expect(page).to have_error_message('Invalid')

    click_link 'Home'
    expect(page).not_to have_error_message('Invalid')
  end

  scenario "when submitting valid data" do
    valid_signin(user)
  
    expect(page).to have_title(user.name)
    expect(page).to have_link('Profile',     href: user_path(user))
    expect(page).to have_link('Sign out',    href: signout_path)
    expect(page).not_to have_link('Sign in', href: signin_path)
  end

  scenario "when signing out" do
    valid_signin(user)

    click_link 'Sign out'
    expect(page).to have_link('Sign in')
  end
end