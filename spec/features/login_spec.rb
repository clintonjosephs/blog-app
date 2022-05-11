require 'rails_helper'

RSpec.describe 'Login Page Features' do
  before do
    FactoryBot.create(:user)
    visit(new_user_session_path)
  end

  scenario 'Username, Password and Submit are displayed' do
    expect(page).to have_field('Email')
    expect(page).to have_field('Password')
    expect(page).to have_button('Log in')
  end

  context 'Login Process' do
    scenario 'Show error detail when the submit button is clicked without entering username and password' do
      click_button('Log in')
      expect(page).to have_content('Invalid Email or password')
    end

    scenario 'Show error detail when the submit button is clicked with incorrect username and password' do
      within 'form' do
        fill_in('Email', with: 'johnlennon@gmail.com')
        fill_in('Password', with: '123456')
      end
      click_button('Log in')
      expect(page).to have_content('Invalid Email or password')
    end

    scenario 'Redirect to the root page when the submit button is clicked with correct username and password' do
      @user = User.first
      within 'form' do
        fill_in('Email', with: @user.email)
        fill_in('Password', with: 'secret')
      end
      click_button('Log in')
      expect(page).to have_current_path(root_path)
      expect(page).to have_content('Signed in successfully')
    end
  end
end
