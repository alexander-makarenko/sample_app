include ApplicationHelper

PAGE_TITLES = {
  about_page:   'About Us',
  contact_page: 'Contact',
  help_page:    'Help',
  home_page:    '',
  signin_page:  'Sign in',
  signup_page:  'Sign up'
  }

RSpec::Matchers.define :have_proper_title_for do |page_name|
  match do |page|
    correct_full_title = full_title(PAGE_TITLES[page_name])
    expect(page).to have_title(correct_full_title)
  end
end

RSpec::Matchers.define :have_h1_header do |header|
  match do |page|
    expect(page).to have_selector('h1', text: header)
  end
end

RSpec::Matchers.define :have_error_message do |message|
  match do |page|
    expect(page).to have_selector('div.alert.alert-danger', text: message)
  end
end

RSpec::Matchers.define :have_success_message do |message|
  match do |page|
    expect(page).to have_selector('div.alert.alert-success', text: message)
  end
end

def invalid_signup
  click_button 'Create my account'
end

def valid_signup(user)
  fill_in 'Name',         with: user.name
  fill_in 'Email',        with: user.email
  fill_in 'Password',     with: user.password
  fill_in 'Confirmation', with: user.password_confirmation
  click_button 'Create my account'
end

def invalid_signin
  click_button 'Sign in'
end

def valid_signin(user)
  fill_in 'Email',    with: user.email.upcase
  fill_in 'Password', with: user.password
  click_button 'Sign in'
end