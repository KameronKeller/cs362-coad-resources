require 'rails_helper'

RSpec.describe 'Capturing a ticket', type: :feature do

    it'As approved org capture a ticket ' do
        #log in as approved org/user
        ticket = create(:ticket)
        organization = create(:organization, :approved)
        user = create(:user, organization: organization)
        not_approved_organization = create(:organization)

        log_in_as(user)
        visit dashboard_path

        #navigate to tickets
        click_on 'Tickets'
        click_on 'FakeTicket'
        click_on 'Capture'

        expect(page).to have_content 'FakeTicket'



    end

end
