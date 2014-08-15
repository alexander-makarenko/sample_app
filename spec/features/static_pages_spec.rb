require 'rails_helper'

feature "Static pages" do
  
  subject { page }

  feature "Home page" do
    background { visit root_path }
    
    it { should have_selector('h1', text: 'Sample App') }
    it { should have_title(full_title('')) }
    it { should_not have_title("| Home") }
  end

  feature "Help page" do
    background { visit help_path }
    
    it { should have_selector('h1', text: 'Help') }
    it { should have_title(full_title('Help')) }
  end

  feature "About page" do
    background { visit about_path }

    it { should have_selector('h1', text: 'About Us') }
    it { should have_title(full_title('About Us')) }
  end

  feature "Contact page" do
    background { visit contact_path }
  
    it { should have_selector('h1', text: 'Contact') }
    it { have_title(full_title('Contact')) }
  end

  scenario "clicking layout links" do
    visit root_path
    click_link 'About'
    expect(page).to have_title(full_title('About Us'))
    click_link 'Help'
    expect(page).to have_title(full_title('Help'))
    click_link 'Contact'
    expect(page).to have_title(full_title('Contact'))
    click_link 'Home'
    click_link 'Sign up now!'
    expect(page).to have_title(full_title('Sign up'))
    click_link "sample app"
    expect(page).to have_title(full_title(''))
  end
end