require 'rails_helper'

feature "User pages" do
  
  subject { page }

  feature "signup page" do
    background { visit signup_path }
    
    it { should have_selector('h1', text: 'Sign up') }
    it { should have_title(full_title('Sign up')) }
  end
end