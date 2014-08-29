require 'rails_helper'

describe "Authorization" do
  let(:user) { create :user }
  
  context "not signed in" do
    describe "submitting a PATCH request to the Users#update action" do
      before  { patch user_path(user) }
      specify { expect(response).to redirect_to(signin_path) }
    end

    describe "submitting a DELETE request to the Users#destroy action" do
      before  { delete user_path(user) }
      specify { expect(response).to redirect_to(signin_path) }
    end
  end

  context "as wrong user" do
    let(:wrong_user) { create :user, email: 'wrong@example.com' }
    before { sign_in user, no_capybara: true }

    describe "submitting a PATCH request to the Users#update action" do
      before  { patch user_path(wrong_user) }
      specify { expect(response).to redirect_to(root_path) }
    end
  end

  context "as non-admin user" do
    let(:user)      { create :user }
    let(:non_admin) { create :user }
    before { sign_in non_admin, no_capybara: true }

    describe "submitting a DELETE request to the Users#destroy action" do
      before  { delete user_path(user) }
      specify { expect(response).to redirect_to(root_path) }
    end
  end

  context "as admin user" do
    let(:admin) { create :admin }
    before { sign_in admin, no_capybara: true }

    describe "submitting a DELETE request to the Users#destroy action" do
      before  { delete user_path(admin) }
      specify { expect(response).to redirect_to(root_path) }
    end
  end

  context "signed in" do
    before { sign_in user, no_capybara: true }

    describe "submitting a POST request to the Users#create action" do
      before  { post users_path }
      specify { expect(response).to redirect_to(root_path) }
    end
  end
end

describe "Forbidden attributes" do
  let(:user) { create :user }
  let(:params) do
    { user: { admin: true, password: user.password,
              password_confirmation: user.password } }
  end

  before do
    sign_in user, no_capybara: true
    patch user_path(user), params
  end

  specify { expect(user.reload).not_to be_admin }
end