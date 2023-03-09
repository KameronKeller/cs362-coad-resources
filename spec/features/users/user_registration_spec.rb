require 'rails_helper'

RSpec.describe 'User registration', type: :feature do


    it 'registering a new user' do
        visit root_path
        click_on 'Sign up'
        fill_in 'user_email', with: 'test@test.com'
        fill_in 'user_password', with: '1234567'  
        fill_in 'user_password_confirmation', with: '1234567'
        #click_on 'recaptcha-checkbox-checkmark' 
        click_on 'commit' 
    
        expect(page).to have_content 'email'
        
    end

end
