require 'rails_helper'

feature "Static pages" do

  scenario "when visiting the Home page" do
    visit root_path
  
    expect(page).to have_h1_header 'Sample App'
    expect(page).to have_title_expected_for :home_page
    expect(page).not_to have_title '| Home'
  end

  scenario "when visiting the Help page" do
    visit help_path
    
    expect(page).to have_h1_header 'Help'
    expect(page).to have_title_expected_for :help_page
  end

  scenario "when visiting the About page" do
    visit about_path

    expect(page).to have_h1_header 'About Us'
    expect(page).to have_title_expected_for :about_page
  end

  scenario "when visiting the Contact page" do
    visit contact_path

    expect(page).to have_h1_header 'Contact'
    expect(page).to have_title_expected_for :contact_page
  end

  scenario "when clicking the layout links" do
    visit root_path
    click_link 'About'
    expect(page).to have_title_expected_for :about_page
    click_link 'Help'
    expect(page).to have_title_expected_for :help_page
    click_link 'Contact'
    expect(page).to have_title_expected_for :contact_page
    click_link 'Home'
    click_link 'Sign up now!'
    expect(page).to have_title_expected_for :signup_page
    click_link 'Sign in'
    expect(page).to have_title_expected_for :signin_page
    click_link "sample app"
    expect(page).to have_title_expected_for :home_page
  end
end