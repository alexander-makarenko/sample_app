require 'rails_helper'

feature "User pages" do
  
  subject { page }

  feature "signup page" do
    background { visit signup_path }
    
    it { should have_selector('h1', text: 'Sign up') }
    it { should have_title(full_title('Sign up')) }
  end

  feature "signup with invalid data" do
    background { visit signup_path }
    given(:submit) { 'Create my account' }

    scenario "the user submits the empty form" do
      expect { click_button submit }.not_to change(User, :count)
    end

    feature "after submission the validation errors should be displayed" do
      background { click_button submit }

      it { should have_css('div.alert.alert-danger', text: 'error') }
    end      
  end
  
  feature "signup with valid data" do
    background { visit signup_path }
    given(:submit) { 'Create my account' }

    given(:user) { FactoryGirl.build(:user) }
    background do
      fill_in 'Name',         with: user.name
      fill_in 'Email',        with: user.email
      fill_in 'Password',     with: user.password
      fill_in 'Confirmation', with: user.password_confirmation
    end
    
    scenario "the user submits the filled out form" do
      expect { click_button submit }.to change(User, :count).by(1)
    end

    feature "after submission the user should be redirected to the profile page" do
      background { click_button submit }
      given(:found_user) { User.find_by(email: user.email) }

      it { should have_title(found_user.name) }

      feature "a flash message should be displayed" do
        it { should have_css('div.alert.alert-success', text: 'Welcome') }

        # feature "the flash message should disappear on page reload" do
        #   background { visit current_path }
        #   it { should_not have_css('div.alert.alert-success', text: 'Welcome') }
        # end
      end
    end
  end

  feature "profile page" do
    let(:user) { FactoryGirl.create(:user) }
    background { visit user_path(user) }

    it { should have_content(user.name) }
    it { should have_title(user.name) }
  end
end