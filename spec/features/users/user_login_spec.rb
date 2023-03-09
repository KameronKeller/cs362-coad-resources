require 'rails_helper'

RSpec.describe 'Logging in', type: :feature do

    it 'logging in as a created user' do
        user = create(:user)
        visit root_path
        click_on 'Log in'
        fill_in 'user_email', with: user.email
        fill_in 'user_password', with: user.password
        click_on 'Sign in'

        expect(page).to have_content 'Dashboard'
    
    end

end
