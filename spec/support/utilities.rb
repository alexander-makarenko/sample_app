include ApplicationHelper

PAGE_TITLES = {
  about_page:       'About Us',
  contact_page:     'Contact',
  help_page:        'Help',
  home_page:        '',
  signin_page:      'Sign in',
  signup_page:      'Sign up',
  edit_user_page:   'Edit user',
  users_index_page: 'All users'
  }

RSpec::Matchers.define :have_title_expected_for do |page_name|
  match do |page|
    proper_full_title = full_title(PAGE_TITLES[page_name])
    expect(page).to have_title(/^#{proper_full_title}$/)
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

def fail_to_sign_up
  click_button 'Create my account'
end

def sign_up(user)
  fill_in 'Name',             with: user.name
  fill_in 'Email',            with: user.email
  fill_in 'Password',         with: user.password
  fill_in 'Confirm password', with: user.password_confirmation
  click_button 'Create my account'
end

def fail_to_sign_in
  click_button 'Sign in'
end

def sign_in(user, opts={})
  if opts[:no_capybara]
    # Sign in when not using Capybara
    remember_token = User.new_remember_token
    cookies[:remember_token] = remember_token
    user.update_attribute(:remember_token, User.digest(remember_token))
  else
    fill_in 'Email',    with: user.email.upcase
    fill_in 'Password', with: user.password
    click_button 'Sign in'
  end
end

def fail_to_update_user
  click_button 'Save changes'
end

def update_user(user, opts={})
  original_attrs = { name: user.name, email: user.email, password: user.password }
  updated_attrs = original_attrs.merge(opts[:with])

  fill_in 'Name',             with: updated_attrs[:name]
  fill_in 'Email',            with: updated_attrs[:email]
  fill_in 'Password',         with: updated_attrs[:password]
  fill_in 'Confirm password', with: updated_attrs[:password]
  click_button 'Save changes'
end