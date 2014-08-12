require 'rails_helper'

feature "Static pages" do
  
  given(:base_title) { 'Ruby on Rails Tutorial Sample App' }

  feature "Home page" do
    background { visit '/static_pages/home' }
    
    scenario "should have the content 'Sample App'" do
      expect(page).to have_content('Sample App')
    end

    scenario "should have the base" do
      expect(page).to have_title("#{base_title}")
    end

    scenario "should not have a custom page title" do
      expect(page).not_to have_title("| Home")
    end
  end

  feature "Help page" do
    background { visit '/static_pages/help' }
    
    scenario "should have the content 'Help'" do
      expect(page).to have_content('Help')
    end

    scenario "should have the right title" do
      expect(page).to have_title("#{base_title} | Help")
    end
  end

  feature "About page" do
    background { visit '/static_pages/about' }

    scenario "should have the content 'About Us'" do
      expect(page).to have_content('About Us')
    end

    scenario "should have the right title" do
      expect(page).to have_title("#{base_title} | About")
    end
  end

  feature "Contact page" do
    background { visit '/static_pages/contact' }
  
    scenario "should have the content 'Contact'" do
      expect(page).to have_content('Contact')
    end

    scenario "should have the right title" do
      expect(page).to have_title("#{base_title} | Contact")
    end
  end
end