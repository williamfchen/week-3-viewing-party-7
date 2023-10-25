require 'rails_helper'

describe 'User Login' do
  before(:each) do
    @user = User.create(name: "John Doe", email: "john@example.com", password: "password")
  end

  it 'allows a registered user to log in' do
    visit root_path
    
    click_link "Log In"
    
    expect(current_path).to eq(login_form_path)
    
    fill_in :email, with: @user.email
    fill_in :password, with: "password"
    
    click_button "Log In"
    
    expect(current_path).to eq(user_path(@user))
  end

  it 'displays an error when credentials are incorrect' do
    visit root_path
    
    click_link "Log In"
    
    fill_in :email, with: @user.email
    fill_in :password, with: "wrong_password"
    
    click_button "Log In"
    
    expect(current_path).to eq(login_form_path)
    expect(page).to have_content("Invalid email or password")
  end
end