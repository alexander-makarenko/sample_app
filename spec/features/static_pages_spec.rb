require 'rails_helper'

feature "Static pages" do
  
  feature "Home page" do
    background { visit '/static_pages/home' }
  
    scenario "should have the content 'Sample App'" do
      expect(page).to have_content('Sample App')
    end

    scenario "should have the right title" do
      expect(page).to have_title("Ruby on Rails Tutorial Sample App | Home")
    end
  end

  feature "Help page" do
    background { visit '/static_pages/help' }
    
    scenario "should have the content 'Help'" do
      expect(page).to have_content('Help')
    end

    scenario "should have the right title" do
      expect(page).to have_title("Ruby on Rails Tutorial Sample App | Help")
    end
  end

  feature "About page" do
    background { visit '/static_pages/about' }

    scenario "should have the content 'About Us'" do
      expect(page).to have_content('About Us')
    end

    scenario "should have the right title" do
      expect(page).to have_title("Ruby on Rails Tutorial Sample App | About")
    end
  end
end