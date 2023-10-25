require 'rails_helper'

describe 'User Logout' do
  before(:each) do
    @user = User.create(name: "John Doe", email: "john@example.com", password: "password")
    visit login_form_path
    fill_in :email, with: @user.email
    fill_in :password, with: "password"
    click_button "Log In"
  end

  it 'can log out a logged-in user' do
    visit root_path

    expect(page).to_not have_link("Log In")
    expect(page).to_not have_link("Create an Account")
    expect(page).to have_link("Log Out")

    click_link "Log Out"

    expect(current_path).to eq(root_path)
    expect(page).to have_content("Logged out successfully!")
    expect(page).to have_link("Log In")
    expect(page).to_not have_link("Log Out")
  end
end