require 'rails_helper'

RSpec.describe 'Closing a ticket', type: :feature do


    it'As approved org close a ticket ' do
        #log in as approved org/user
        organization = create(:organization, :approved)
        user = create(:user, organization: organization)
        not_approved_organization = create(:organization)
        ticket = create(:ticket, organization_id: user.organization_id)


        log_in_as(user)
        visit dashboard_path

        #navigate to tickets
        click_on 'Tickets'

        expect(page).to have_content 'FakeTicket' #confirms theres the fake ticket in captured
        click_on 'FakeTicket'
        click_on 'Close'
        click_on 'Tickets'
        click_on 'FakeTicket'
        expect(page).to_not have_content 'Open'
        



    end

end
